import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/model/pollution_response.dart';
import 'package:pollution_environment/src/network/apis/pollution/pollution_api.dart';
import 'package:pollution_environment/src/screen/filter/filter_storage_controller.dart';

class MapController extends GetxController {
  Completer<GoogleMapController> mapController = Completer();
  Rx<CarouselController> carouselController = CarouselController().obs;

  final FilterStorageController _filterStorageController =
      Get.put(FilterStorageController());

  RxSet<Marker> markers = RxSet<Marker>();
  RxList<PollutionModel> pollutions = RxList<PollutionModel>();
  Rxn<int> indexPollutionSelected = Rxn<int>();

  @override
  void onInit() {
    super.onInit();

    getPollutionPosition();
  }

  final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(20.9109654, 105.8113753),
    zoom: 14.4746,
  );

  void getPos() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 13)));
  }

  getPollutionPosition() async {
    PollutionsResponse? pollutionsResponse =
        await PollutionApi().getAllPollution(
      limit: 100,
      provinceName: _filterStorageController.selectedProvince.value?.id == "-1"
          ? null
          : _filterStorageController.selectedProvince.value?.name,
      districtName: _filterStorageController.selectedDistrict.value?.id == "-1"
          ? null
          : _filterStorageController.selectedDistrict.value?.name,
      wardName: _filterStorageController.selectedWard.value?.id == "-1"
          ? null
          : _filterStorageController.selectedWard.value?.name,
    );
    var list = pollutionsResponse.results ?? [];

    _addMarker(list);
  }

  _addMarker(List<PollutionModel> list) async {
    markers.clear();
    pollutions.clear();
    for (var item in list) {
      if (item.lat != null &&
          item.lng != null &&
          item.type != null &&
          item.qualityScore != null) {
        var icon = await getMarkerIcon(item.type!, item.qualityScore!);
        pollutions.add(item);
        markers.add(Marker(
            markerId: MarkerId(item.id!),
            position: LatLng(item.lat!, item.lng!),
            icon: icon,
            onTap: () {
              int index =
                  pollutions.indexWhere((element) => element.id == item.id);
              if (indexPollutionSelected.value != index) {
                if (indexPollutionSelected.value != null)
                  carouselController.value.animateToPage(index);
                indexPollutionSelected.value = index;
              } else {
                indexPollutionSelected.value = null;
              }
            }));
      }
    }
  }

  Future<BitmapDescriptor> getMarkerIcon(String type, int quality) async {
    final Size size = Size(120, 120);
    Color color = getQualityColor(quality);

    final imagePath = getAssetPollution(type);
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    final Paint shadowPaint = Paint()..color = color;
    final double shadowWidth = 10.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 5.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    // Oval for the image
    Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
        size.width - (imageOffset * 2), size.height - (imageOffset * 2));

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    // Add image
    if (imagePath != null) {
      ui.Image image = await getImageFromPath(
          imagePath); // Alternatively use your own method to get the image
      paintImage(
          canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);
    }

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());

    // Convert image to bytes
    final ByteData? byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }
}
