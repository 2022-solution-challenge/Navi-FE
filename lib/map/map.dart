// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:math';
// import 'package:geolocator/geolocator.dart';

class MapApp extends StatelessWidget{
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
class MapSampleState extends State<MapSample> {

  // Future<Position> getLocation() async{
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   return position;
  // }

  // Future<Position> position = getLocation();

  late GoogleMapController _controller; //컨트롤러

  // 지도 클릭 시 표시할 장소에 대한 마커 목록
  final List<Marker> markers = [];

  addMarker(cordinate) {
    int id = Random().nextInt(100);
    setState(() {
      markers
          .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }


  @override
  Widget build(BuildContext context){
    // ignore: sized_box_for_whitespace
    final med = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps test'),
        elevation: 0.0,
        toolbarHeight: 50,
      ),
      body: Container(
        width: med.width,
        // height: MediaQuery.of(context).size.height,
        // width : 300,
        height: med.height,
        child: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: (controller) {
            setState(() {
              _controller = controller;
            });
          },
          markers: markers.toSet(),
          initialCameraPosition: CameraPosition(
              target: LatLng(
                  37.5,
                  126.9294254 // 시작 위치
              ),
              zoom: 18,
            ),
          onTap: (cordinate) {
            _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
            addMarker(cordinate);
          },
        ),
      ),
    );

  }

}