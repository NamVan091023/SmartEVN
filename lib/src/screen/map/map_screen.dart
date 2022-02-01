import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/model/internal.dart';
import 'package:pollution_environment/src/model/pollution_position_model.dart';
import 'package:pollution_environment/src/screen/filter/filter_screen.dart';
import 'package:pollution_environment/src/screen/station_screen.dart';

class MapScreen extends StatefulWidget {
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with AutomaticKeepAliveClientMixin<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  List<PollutionPosition> positions = [];
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.9109654, 105.8113753),
    zoom: 14.4746,
  );

  void getPos() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 13)));
  }

  bool isShowInformation = false;
  bool isFirstTime = true;
  final List<Marker> myMarker = [];

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    getPos();
    _getPollutionPosition();
    Internal().eventBus.on<PollutionPosition>().listen((event) {
      setState(() {});
    });
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            onCameraIdle: null,
            onCameraMove: null,
            myLocationButtonEnabled: false,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Set.from(myMarker),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.7, right: size20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => StationData()))
                        .then((value) => {_addMarker(value)}),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: primaryColor),
                      child: Icon(Icons.wb_sunny_outlined),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => FilterScreen(positions)))
                        .then((value) => {_addMarker(value)}),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: primaryColor),
                      child: Icon(Icons.filter_alt_outlined),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _getPollutionPosition();
                      setState(() {
                        isShowInformation = !isShowInformation;
                      });
                    },
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: primaryColor),
                        child: Icon(Icons.info_outline)),
                  )
                ],
              ),
            ),
          ),
          isShowInformation ? _buildNoteScreen() : SizedBox()
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;

  _getPollutionPosition() async {
    if (isFirstTime) {
      isFirstTime = false;
      PollutionPositionModel? data = null;
      // await PollutionNetwork().getPollutionPosition();
      data?.data?.pollutionPosition!.length;
      positions.clear();
      positions.addAll(data!.data!.pollutionPosition!);
      positions.addAll(Internal().listPosition);
      positions.add(PollutionPosition(
          type: "AIR",
          longitude: "20.9109654",
          latitude: "105.8113753",
          id: "1"));
      positions.add(PollutionPosition(
          type: "WATER",
          longitude: "21.9109654",
          latitude: "105.7113753",
          id: "2"));

      _addMarker(positions);
    }
  }

  _addMarker(List<PollutionPosition> list) {
    myMarker.clear();
    for (var item in list) {
      myMarker.add(
        Marker(
            position: LatLng(
                double.parse(item.latitude!), double.parse(item.longtitude!)),
            icon: BitmapDescriptor.defaultMarkerWithHue(item.type == "AIR"
                ? BitmapDescriptor.hueBlue
                : item.type == "WATER"
                    ? BitmapDescriptor.hueGreen
                    : BitmapDescriptor.hueOrange),
            markerId: MarkerId(item.id!)),
      );
    }
    setState(() {
      myMarker.length;
    });
  }

  Widget _buildNoteScreen() {
    return Scaffold(
        backgroundColor: Colors.black54,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/location.png',
                      height: 50,
                      width: 50,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Text('Không khí',
                        style: TextStyle(
                            fontSize: mainTextSize, color: Colors.deepOrange))
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/location.png',
                      height: 50,
                      width: 50,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Text('Nước',
                        style: TextStyle(
                            fontSize: mainTextSize, color: Colors.deepOrange))
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/location.png',
                      height: 50,
                      width: 50,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Text('Tiếng ồn',
                        style: TextStyle(
                            fontSize: mainTextSize, color: Colors.deepOrange))
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () => setState(() {
            isShowInformation = !isShowInformation;
          }),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(25)),
            child: Icon(Icons.clear),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
