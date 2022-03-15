// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'currentMarker.dart';

import 'dart:async';
import 'dart:math';
// import 'package:geolocator/geolocator.dart';

class MapApp extends StatelessWidget {
  const MapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapSample(),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

// class GeoLocatorService{

// }

class PrimitiveWrapper {
  List<Marker> markerlist;
  PrimitiveWrapper(this.markerlist);
}

class MapSampleState extends State<MapSample> {
  // Future<Position> getLocation() async{
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   return position;
  // }

  // Future<Position> position = getLocation();

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  late GoogleMapController _controller; //컨트롤러

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  // 지도 클릭 시 표시할 장소에 대한 마커 목록
  final markers = new PrimitiveWrapper([]);
  final mymarkers = new PrimitiveWrapper([]);
  //final List<Marker> markers =
  //    []; //markers : 현재 선택한 marker로, onTap으로 infowindow와 bottommodal이 올라가게 동작
  //final List<Marker> mymarkers =
  //    []; //mymarkers : 내가 북마크에 추가한 marker로, 눌러도 특별한 동작이 되지 않음

  showMarker(cordinate) {
    int id = Random().nextInt(100); //나중에 수정
    setState(() {
      _customInfoWindowController.hideInfoWindow!();
      (markers.markerlist).clear(); //전에 찍은 곳은 안보이게 -> 클리어하고 add
      (markers.markerlist).add(currentMarker(cordinate, id, context, _customInfoWindowController, mymarkers));
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    final med = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps test'),
        elevation: 0.0,
        toolbarHeight: 50,
      ),
      body: Stack(
          // height: MediaQuery.of(context).size.height,
          // width : 300,
          children: <Widget>[
            GoogleMap(
              onTap: (position) {
                _customInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                _customInfoWindowController.onCameraMove!();
              },
              mapType: MapType.normal,
              onMapCreated: (controller) {
                setState(() {
                  _controller = controller;
                  _customInfoWindowController.googleMapController = controller;
                });
              },
              markers: (mymarkers.markerlist + markers.markerlist).toSet(),
              initialCameraPosition: CameraPosition(
                target: LatLng(37.5, 126.9294254 // 시작 위치
                    ),
                zoom: 18,
              ),
              onLongPress: (cordinate) {
                _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
                showMarker(cordinate);
              },
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 75,
              width: 150,
              offset: 50,
            ),
          ]),
    );
  }
}
