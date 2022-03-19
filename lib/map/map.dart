// ignore_for_file: prefer_const_constructors
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:http/http/dart' as http;

class MapApp extends StatelessWidget{
  const MapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialApp(
        title: 'Google Maps',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MapSample(),
      ),
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
  List<Marker> _markers = [];

  @override
  void initState(){
    _markers.add(Marker(
      markerId: MarkerId("first marker"),
      draggable: true,
      onTap: () => print("Tappend"),
      position: LatLng(
          37.5283169,
          126.9294254
      )
    ));
  }


  @override
  Widget build(BuildContext context){
    // ignore: sized_box_for_whitespace
    // med => media query calculate
    final med = MediaQuery.of(context).size;
    final textController = TextEditingController();
    String? textToFind;
    // _locationData = locateUser();

    return Scaffold(

      body: Column(
        children: <Widget>[
          Container(
            width: med.width,
            // height: MediaQuery.of(context).size.height,
            // width : 300,
            height: med.height*0.6,
            child: GoogleMap(
              mapType: MapType.normal,
              markers: Set.from(_markers),
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  // _locationData.latitude,
                  // _locationData.longitude
                    37.5283169,
                    126.9294254
                ),
                zoom: 18,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Where to go?',
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              OutlinedButton(
                onPressed: (){
                  textToFind = textController.text;
                  //Respond to button press
                },
                child: Text("Find"),
              )
            ],
          )


        ],
      )
    );

  }

}

//location data가져오는 부분
void getLocationData() async {
  String url = "";
  var response = await http.get(url);
  var statusCode = response.statusCode;
  var responseHeaders = response.headers;
  var responseBody = response.body;


}