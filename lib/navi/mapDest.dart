import 'dart:async';

import 'package:flutter/material.dart';
import './directions_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_controller/google_maps_controller.dart';

import 'directions_model.dart';

class NaviMainApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Navigation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>{

  Completer<GoogleMapController> _googleMapController = Completer();
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );
  // var _googleMapController = GoogleMapController(
  //   initialCameraPosition : _initialCameraPosition,
  // );
  late Marker _origin;
  late Marker _destination;
  late Directions _info;
  Set<Marker> markerList = new Set();
  //
  // @override
  // void dispose(){
  //   _googleMapController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Navigation demo'),
        actions: [
          TextButton(
            onPressed: () {
              CameraPosition newPosition = new CameraPosition(target: markerList.first.position,zoom: 14.5,tilt: 50.0);
              _setCamera(newPosition);
            },
            style: TextButton.styleFrom(
              primary: Colors.green,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: Text('Origin'),
          ),
          TextButton(
            onPressed: () {
              CameraPosition newPosition = new CameraPosition(target: markerList.last.position,zoom: 14.5,tilt: 50.0);
              _setCamera(newPosition);
            },
            style: TextButton.styleFrom(
              primary: Colors.white70,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: Text('Dest'),
          ),
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller){
          _googleMapController.complete(controller);
        },
        markers: markerList,
        onLongPress: _addMarker,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white70,
        onPressed: () => _setCamera(_initialCameraPosition),
        child: const Icon(Icons.center_focus_strong_outlined),
      ),
    );
  }

  void _addMarker(LatLng pos){
    if(markerList.length != 1){
      //set origin
      setState(() {
        if(markerList.length >= 2){
          markerList.clear();
        }
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        markerList.add(_origin);
      });
    } else {
      //set dest
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
        markerList.add(_destination);
      });
    }
  }

  Future<void> _setCamera(CameraPosition cp) async {
    final GoogleMapController controller = await _googleMapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        cp
      )
    );
  }

  //Get Directions
  final directions = await DirectionsRepository()
}