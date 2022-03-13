// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

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





class MapSampleState extends State<MapSample> {
  late LatLng center;
  late Position _locationData;



  Future<Position> locateUser() async {
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }



  @override
  Widget build(BuildContext context){
    // ignore: sized_box_for_whitespace
    // med => media query calculate
    final med = MediaQuery.of(context).size;
    _locationData = locateUser();

    return Scaffold(

      body: _locationData != null ? Container(
        width: med.width,
        // height: MediaQuery.of(context).size.height,
        // width : 300,
        height: med.height,
        child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                _locationData.latitude,
                _locationData.longitude
              ),
              zoom: 18,
            ),
        ),
      ),
    );

  }

}