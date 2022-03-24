import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/navi/accident_marker.dart';
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

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _googleMapController = Completer();
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(38.518811, -121.101664),
    zoom: 11.5,
  );
  // var _googleMapController = GoogleMapController(
  //   initialCameraPosition : _initialCameraPosition,
  // );
  late Marker _origin;
  late Marker _destination;
  Directions? _info;
  Set<Marker> markerList = new Set();
  Set<Marker> accidentMarkerList = Set();
  Set<Circle> accidentCircleList = Set();
  //
  // @override
  // void dispose(){
  //   _googleMapController.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    setInitAccidentMarker();
  }

  @override
  Widget build(BuildContext context) {
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
        onMapCreated: (GoogleMapController controller) {
          _googleMapController.complete(controller);
        },
        markers: accidentMarkerList.union(markerList),
        circles: accidentCircleList,
        polylines: {
          if (_info != null)
            Polyline(
              polylineId: const PolylineId('overview polyline'),
              color: Colors.red,
              width: 5,
              points: _info!.polylinePoints
                  .map((e) => LatLng(e.latitude, e.longitude))
                  .toList(),
            )
        },
        onLongPress: _addMarker,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white70,
        onPressed: () {
          _info != null
              ? _setBounds(_info)
              : _setCamera(_initialCameraPosition);
        },
        child: const Icon(Icons.center_focus_strong_outlined),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
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

        _info = null;
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


      //Get Directions
      final directions = await DirectionRepository().getDirections(origin: _origin.position, destination : _destination.position);
      setState(() => _info = directions);
    }
  }

  Future<void> _setCamera(CameraPosition cp) async {
    final GoogleMapController controller = await _googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cp));
  }

  Future<void> _setBounds(Directions? directions) async {
    final GoogleMapController controller = await _googleMapController.future;
    if (directions == null) {
      throw new Exception('Direction is null');
    }
    controller
        .animateCamera(CameraUpdate.newLatLngBounds(directions.bounds, 100.0));
  }

  void setInitAccidentMarker() async {
    debugPrint('mapping data ===================');

    List<Marker> _accidentMarkerList = [];
    List<Circle> _accidentCircleList = [];

    //marker mapping
    List<Marker> _items = await accidnetItems
        .map((AccidentMarker _items) => Marker(
            markerId: MarkerId((_items.id).toString()),
            position: LatLng((_items.startLat + _items.endLat) / 2,
                (_items.startLng + _items.startLng) / 2)))
        .toList();
    _accidentMarkerList.addAll(_items);

    //circle mapping
    List<Circle> _circles = await accidnetItems
        .map((AccidentMarker _circles) => Circle(
              circleId: CircleId((_circles.id).toString()),
              center: LatLng((_circles.startLat + _circles.endLat) / 2,
                  (_circles.startLng + _circles.startLng) / 2),
              radius: 1000, //지금 그냥 distance로 하면 너무 작아 보여서 고정 값으로 설정함. 논의필요
              fillColor: Colors.blue.shade100.withOpacity(0.5),
              strokeColor:  Colors.blue.shade100.withOpacity(0.1),
            ))
        .toList();

    _accidentCircleList.addAll(_circles);
    debugPrint('setinitmarker============');

    setState(() {
      debugPrint('====================setState,${_accidentMarkerList}  ===================');
      accidentMarkerList.addAll(_accidentMarkerList.toSet());
      accidentCircleList.addAll(_accidentCircleList.toSet());
    });
    //setState를 사용해서 다시 빌드
  }
}
