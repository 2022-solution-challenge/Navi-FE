// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
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
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  37.5,
                  126.9294254
              ),
              zoom: 18,
            )
        ),
      ),
    );

  }

}