import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/commons/location_service.dart';
import 'package:pollution_environment/src/model/aqi_map_model.dart';
import 'package:pollution_environment/src/model/pollution_response.dart';
import 'package:pollution_environment/src/network/apis/area_forest/area_forest_api.dart';
import 'package:pollution_environment/src/network/apis/pollution/pollution_api.dart';
import 'package:pollution_environment/src/screen/filter/filter_storage_controller.dart';

class MapController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 800));
  late Animation<Offset> offset;

  final FilterStorageController filterStorageController =
      Get.put(FilterStorageController());

  Completer<GoogleMapController> mapController = Completer();

  RxList<ClusterManager> managers = RxList<ClusterManager>();
  RxSet<Polygon> polygons = RxSet<Polygon>();
  List<LatLng> polygonLatLngs = [];
  RxList<Set<Marker>> markers = [
    Set<Marker>(),
    Set<Marker>(),
    Set<Marker>(),
    Set<Marker>(),
    Set<Marker>(),
    Set<Marker>()
  ].obs;

  RxList<List<PollutionModel>> pollutions = RxList<List<PollutionModel>>();

  Rxn<PollutionModel> pollutionSelected = Rxn<PollutionModel>();
  Rxn<Markers> aqiMarkerSelected = Rxn<Markers>();

  RxList<List<Markers>> aqiPointMarkers = RxList<List<Markers>>();
  RxList<ClusterManager> aqiManagers = RxList<ClusterManager>();
  RxList<Set<Marker>> aqiMarkers = [
    Set<Marker>(),
    Set<Marker>(),
    Set<Marker>(),
    Set<Marker>(),
    Set<Marker>(),
    Set<Marker>()
  ].obs;

  Timer? _debounce;

  @override
  void onInit() {
    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(animationController);
    super.onInit();

    getPollutionPosition();
    getAQIMap();
    _initClusterManager();
  }

  void _initClusterManager() {
    for (int i = 0; i < 6; i++) {
      pollutions.add([]);
      managers.add(ClusterManager<PollutionModel>(pollutions[i].toList(),
          (Set<Marker> markers) {
        this.markers.toList()[i].clear();
        this.markers.toList()[i].addAll(markers);
        this.markers.refresh();
      }, markerBuilder: _getMarkerBuilder(getQualityColor(i + 1))));
    }
    for (int i = 0; i < 6; i++) {
      aqiPointMarkers.add([]);
      aqiManagers.add(ClusterManager<Markers>(aqiPointMarkers[i].toList(),
          (Set<Marker> markers) {
        this.aqiMarkers.toList()[i].clear();
        this.aqiMarkers.toList()[i].addAll(markers);
        this.aqiMarkers.refresh();
      }, markerBuilder: _getAQIMarkerBuilder(getQualityColor(i + 1))));
    }

    pollutions.refresh();
    this.managers.refresh();

    aqiPointMarkers.refresh();
    this.aqiManagers.refresh();
  }

  Future<Marker> Function(Cluster<PollutionModel>) _getMarkerBuilder(
          Color color) =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () async {
            var firstPollution = cluster.items.first;
            pollutionSelected.value = firstPollution;
            aqiMarkerSelected.value = null;
            if (cluster.isMultiple) {
              final GoogleMapController controller = await mapController.future;
              controller.animateCamera(CameraUpdate.newLatLngZoom(
                  LatLng(firstPollution.lat!, firstPollution.lng!), 8));
            }
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75, color,
              text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };

  Future<Marker> Function(Cluster<Markers>) _getAQIMarkerBuilder(Color color) =>
      (cluster) async {
        double avg = 0;
        cluster.items.forEach((element) {
          avg += element.aqi ?? 0;
        });
        avg /= cluster.items.length;
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () async {
            var firstAQI = cluster.items.first;
            aqiMarkerSelected.value = firstAQI;
            pollutionSelected.value = null;
            if (cluster.isMultiple) {
              final GoogleMapController controller = await mapController.future;
              controller.animateCamera(CameraUpdate.newLatLngZoom(
                  LatLng(firstAQI.coordinates!.latitude!,
                      firstAQI.coordinates!.longitude!),
                  8));
            }
          },
          icon: await _getAQIMarkerBitmap(cluster.isMultiple ? 125 : 100, color,
              text: cluster.isMultiple
                  ? "${avg.toStringAsFixed(1)}+"
                  : "${avg.toStringAsFixed(1)}"),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, Color color,
      {String? text}) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = color.withOpacity(0.3);
    final Paint paint2 = Paint()..color = color;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.6, paint2);
    // canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3.5,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      ) as InlineSpan?;
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  Future<BitmapDescriptor> _getAQIMarkerBitmap(int size, Color color,
      {String? text}) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.white;
    final Paint paint2 = Paint()..color = color;

    final path = Path();
    Rect rect = Rect.fromPoints(
        Offset(0, 0), Offset(size.toDouble(), size.toDouble()) - Offset(0, 20));
    path
      ..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 2)))
      ..moveTo(rect.bottomCenter.dx - 15, rect.bottomCenter.dy)
      ..relativeLineTo(15, 20)
      ..relativeLineTo(15, -20);
    path.close();
    canvas.drawPath(path, paint2);

    final path2 = Path();
    Rect rect2 = Rect.fromPoints(Offset(5, 5),
        Offset(size.toDouble() - 5, size.toDouble() - 5) - Offset(0, 23));
    path2
      ..addRRect(
          RRect.fromRectAndRadius(rect2, Radius.circular(rect2.height / 2)))
      ..moveTo(rect2.bottomCenter.dx - 10, rect2.bottomCenter.dy)
      ..relativeLineTo(10, 15)
      ..relativeLineTo(10, -15);
    path2.close();
    canvas.drawPath(path2, paint1);

    final path3 = Path();
    Rect rect3 = Rect.fromPoints(Offset(8, 8),
        Offset(size.toDouble() - 8, size.toDouble() - 8) - Offset(0, 23));
    path3
      ..addRRect(
          RRect.fromRectAndRadius(rect3, Radius.circular(rect3.height / 2)))
      ..moveTo(rect3.bottomCenter.dx - 13, rect3.bottomCenter.dy);
    path3.close();
    canvas.drawPath(path3, paint2);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3.5,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      ) as InlineSpan?;
      painter.layout();
      painter.paint(
        canvas,
        Offset(
            size / 2 - painter.width / 2, size / 2 - painter.height / 2 - 10),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(20.9109654, 105.8113753),
    zoom: 14.4746,
  );

  void getPos() async {
    Position position = await LocationService().determinePosition();
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 13)));
  }

  getAQIMap() async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      if (filterStorageController.isFilterAQI.value) {
        GoogleMapController map = await mapController.future;
        double zoomLevel = await map.getZoomLevel();
        var aqiResponse = await AreaForestAPI().getAQIMap(zoomLevel);
        for (int i = 0; i < 6; i++) {
          aqiPointMarkers.toList()[i].clear();
        }
        aqiResponse.markers?.forEach((element) {
          num aqi = element.aqi ?? 0;
          if (aqi >= 0 && aqi <= 50) aqiPointMarkers.toList()[5].add(element);
          if (aqi >= 51 && aqi <= 100) aqiPointMarkers.toList()[4].add(element);
          if (aqi >= 101 && aqi <= 150)
            aqiPointMarkers.toList()[3].add(element);
          if (aqi >= 151 && aqi <= 200)
            aqiPointMarkers.toList()[2].add(element);
          if (aqi >= 201 && aqi <= 300)
            aqiPointMarkers.toList()[1].add(element);
          if (aqi >= 301) aqiPointMarkers.toList()[0].add(element);
        });
        aqiPointMarkers.refresh();
        for (int i = 0; i < 6; i++) {
          aqiManagers.toList()[i].setItems(aqiPointMarkers[i].toList());
        }
      } else {
        for (int i = 0; i < 6; i++) {
          aqiPointMarkers.toList()[i].clear();
          aqiManagers.toList()[i].setItems(aqiPointMarkers[i].toList());
          aqiMarkers.toList()[i].clear();
        }
        aqiPointMarkers.refresh();
      }

      aqiMarkers.refresh();
      aqiManagers.refresh();
    });
  }

  getPollutionPosition() async {
    PollutionsResponse? pollutionsResponse = await PollutionApi()
        .getAllPollution(
            limit: 100,
            provinceName:
                filterStorageController.selectedProvince.value?.id == "-1"
                    ? null
                    : filterStorageController.selectedProvince.value?.name,
            districtName:
                filterStorageController.selectedDistrict.value?.id == "-1"
                    ? null
                    : filterStorageController.selectedDistrict.value?.name,
            wardName: filterStorageController.selectedWard.value?.id == "-1"
                ? null
                : filterStorageController.selectedWard.value?.name,
            type: filterStorageController.selectedType
                .toList()
                .map((e) => e.key ?? "")
                .toList(),
            quality: filterStorageController.selectedQuality
                .toList()
                .map((e) => e.key ?? "")
                .toList());
    var list = pollutionsResponse.results ?? [];

    _addMarker(list);
    String id =
        "${filterStorageController.selectedProvince.value?.id}${filterStorageController.selectedDistrict.value?.id}";
    await _setPolygon(id);
  }

// Draw Polygon to the map
  Future<void> _setPolygon(String id) async {
    var polygon = filterStorageController.polygon.toList();
    var bbox = filterStorageController.bbox.toList();
    polygonLatLngs.clear();
    polygon.forEach((element) {
      polygonLatLngs.add(LatLng(element.last, element.first));
    });
    polygons.clear();
    if (polygonLatLngs.length > 3) {
      polygons.add(Polygon(
        polygonId: PolygonId(id),
        points: polygonLatLngs,
        strokeWidth: 2,
        strokeColor: Colors.red,
        fillColor: Colors.yellow.withOpacity(0.75),
      ));
    }

    polygons.refresh();
    if (bbox.length == 4) {
      final GoogleMapController controller = await mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(
          LatLngBounds(
              southwest: LatLng(bbox[1], bbox[0]),
              northeast: LatLng(bbox[3], bbox[2])),
          5));
    }
  }

  _addMarker(List<PollutionModel> list) async {
    for (int i = 0; i < 6; i++) {
      pollutions.toList()[i].clear();
    }
    list.forEach((element) {
      if (element.lat != null &&
          element.lng != null &&
          element.type != null &&
          element.qualityScore != null) {
        pollutions.toList()[element.qualityScore! - 1].add(element);
      }
    });
    pollutions.refresh();
    for (int i = 0; i < 6; i++) {
      managers.toList()[i].setItems(pollutions[i].toList());
    }

    markers.refresh();
    managers.refresh();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
