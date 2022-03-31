import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/navi/mapModel/accident_marker.dart';
import 'directions_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'directions_model.dart';

class NaviMainApp extends StatelessWidget {
  const NaviMainApp({Key? key, required this.DestLocation}) : super(key: key);
  final LatLng DestLocation;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(
        destLocation: this.DestLocation,
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  final LatLng destLocation;
  const MapScreen({Key? key, required this.destLocation}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _googleMapController = Completer();

  late final _initialCameraPosition;
  late Marker _origin;
  late Marker _destination;
  Set<Marker> markerList = new Set();
  Directions? _info = null;

  @override
  void initState() {
    //마커 제작 및 추가
    _origin = Marker(
      markerId: const MarkerId('origin'),
      infoWindow: const InfoWindow(title: 'Origin'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: const LatLng(37.87189568090562, -122.25841638772661),
    );
    _destination = Marker(
      markerId: const MarkerId('destination'),
      infoWindow: const InfoWindow(title: 'Destination'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: widget.destLocation,
    );
    markerList.add(_origin);
    markerList.add(_destination);

    // 길찾는 부분
    DirectionRepository()
        .getDirections(
            origin: _origin.position, destination: _destination.position)
        .then((value) => {
              _info = value,
              if (_info != null)
                pathPointList = _info!.polylinePoints
                    .map((e) => mp.LatLng(e.latitude, e.longitude))
                    .toList(),
              filterMarker(),
            });

    _initialCameraPosition = CameraPosition(
      target: LatLng(
          (_origin.position.latitude + _destination.position.latitude) / 2,
          (_origin.position.longitude + _destination.position.longitude) / 2),
      zoom: 10.5,
    );

    setInitAccidentMarker();
  }

  Set<Marker> accidentMarkerList = Set();
  Set<Circle> accidentCircleList = Set();

  Set<Marker> nearMarkerList = Set();
  Set<Circle> nearCircleList = Set();

  List<Marker> _markers = []; //for moving marker

  int totalNum = 0;

  late List<mp.LatLng> pathPointList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Navigation demo'),
        actions: [
          TextButton(
            onPressed: () {
              CameraPosition newPosition = new CameraPosition(
                  target: LatLng(
                      _origin.position.latitude, _origin.position.longitude),
                  zoom: 14.5,
                  tilt: 50.0);
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
              CameraPosition newPosition = new CameraPosition(
                  target: LatLng(_destination.position.latitude,
                      _destination.position.longitude),
                  zoom: 14.5,
                  tilt: 50.0);
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
        markers: nearMarkerList.union(markerList).union(_markers.toSet()),
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
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white70,
          onPressed: () {
            _info != null
                ? _setBounds(_info)
                : _setCamera(_initialCameraPosition);
            showMoving();
          },
          child: Text(totalNum.toString())
          //const Icon(Icons.center_focus_strong_outlined),
          ),
    );
  }

  bool isMarkerNearPath(Marker marker) {
    //LatLng이 정의된 게 달라서 몹시 번거롭다..

    final pointMp =
        mp.LatLng(marker.position.latitude, marker.position.longitude);
    return mp.PolygonUtil.isLocationOnPath(pointMp, pathPointList, false);
  }

  void filterMarker() {
    List<Marker> temp = accidentMarkerList.toList();

    //marker filtering with condition
    List<Marker> _items = temp.where((i) => isMarkerNearPath(i)).toList();

    setState(() {
      nearMarkerList.clear();
      nearMarkerList.addAll(_items.toSet());

      totalNum = nearMarkerList.length;
    });
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

  void showMoving() async {
    List<LatLng> testList = [
      LatLng(37.87189568090562, -122.25841638772661),
      LatLng(37.872, -122.259),
      LatLng(37.873, -122.261),
      LatLng(37.873, -122.263),
      LatLng(37.873, -122.265),
      LatLng(37.873, -122.267),
      LatLng(37.873, -122.269),
    ];
    for (final position in testList) {
      setState(() {
        if (_markers != []) {
          _markers.removeWhere((m) => m.markerId.value == "sourcePin");
        }

        _markers.add(Marker(
          markerId: MarkerId("sourcePin"),
          position: position, // updated position
          
        ));
      });

      await Future.delayed(Duration(seconds: 3));
    }
  }

  void setInitAccidentMarker() async {
    List<Marker> _accidentMarkerList = [];
    List<Circle> _accidentCircleList = [];

    List<AccidentMarker> accidents = await testAccident();

    //marker mapping
    List<Marker> _items = accidents
        .map((AccidentMarker _items) => Marker(
            markerId: MarkerId((_items.id).toString()),
            position: LatLng((_items.startLat + _items.endLat) / 2,
                (_items.startLng + _items.startLng) / 2)))
        .toList();
    _accidentMarkerList.addAll(_items);

    //circle mapping
    List<Circle> _circles = accidents
        .map((AccidentMarker _circles) => Circle(
              circleId: CircleId((_circles.id).toString()),
              center: LatLng((_circles.startLat + _circles.endLat) / 2,
                  (_circles.startLng + _circles.startLng) / 2),
              radius: 1000, //지금 그냥 distance로 하면 너무 작아 보여서 고정 값으로 설정함. 논의필요
              fillColor: Colors.blue.shade100.withOpacity(0.5),
              strokeColor: Colors.blue.shade100.withOpacity(0.1),
            ))
        .toList();

    _accidentCircleList.addAll(_circles);

    setState(() {
      accidentMarkerList.addAll(_accidentMarkerList.toSet());
      accidentCircleList.addAll(_accidentCircleList.toSet());
    });
    //setState를 사용해서 다시 빌드
  }
}
