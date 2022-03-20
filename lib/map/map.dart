// ignore_for_file: prefer_const_constructors
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'currentMarker.dart';
import 'addedMarker.dart';
import 'bookMark.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // 지도 클릭 시 표시할 장소에 대한 마커 목록
  final markers = new PrimitiveWrapper(
      []); //markers : 현재 선택한 marker로, onTap으로 infowindow와 bottommodal이 올라가게 동작
  final mymarkers = new PrimitiveWrapper(
      []); //mymarkers : 내가 북마크에 추가한 marker로, 눌러도 특별한 동작이 되지 않음

  late Uint8List markerIcon;
  List<BitmapDescriptor> markerIcons = [];
  List<String> paths = [
    'assets/img/star.png',
    'assets/img/heart.png'
  ]; //이미지 path 지정, 하드코딩 해야할듯

  @override
  void initState() {
    super.initState();

    //build 되기 전에 데이터 옮겨오기
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setInitMarker();
    });
  }

  Future<void> setIconImg() async {
    int i = 0;

    // Future.doWhile(() async {
    //   await setCustomMapPin(i);
    //   i++;
    //   debugPrint('converteData: $i');
    //   return !(i < paths.length);
    // });


    // Future.forEach([0, 1], (number) async {
    //   await setCustomMapPin(number);
    //   debugPrint('converteData: $number');
    // });

    for (i = 0; i < paths.length; i++) {
      await setCustomMapPin(i);
      debugPrint('converteData: $i');
    }
  }

  

  Future<void> setCustomMapPin(index) async {
    await Future.delayed(Duration(milliseconds: index*50)); //give delay to load the data...
    markerIcon = await getBytesFromAsset(paths[index], 130);
    markerIcons.add(BitmapDescriptor.fromBytes(markerIcon));

    debugPrint('==========end convert ${index}============');
  }

  void setInitMarker() async {
    await setIconImg();

    debugPrint('mapping data ===================');
    await Future.delayed(Duration(milliseconds: 100));
    List<Marker> _items = await items
        .map((BookMark _items) => addedMarker(
            _items.position, 0, _scaffoldKey, markerIcons, _items.index, _items))
        .toList();
    //데이터를 받아오는 부분
    //좋아요를 어케하지??
    //일단 객체 그 자체를 넘겨준다.
    
    mymarkers.markerlist.addAll(_items);
    debugPrint('setinitmarker============');
    
    setState(() {});
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  showMarker(cordinate) {
    int id = Random().nextInt(100); //나중에 수정
    setState(() {
      _customInfoWindowController.hideInfoWindow!();
      (markers.markerlist).clear(); //전에 찍은 곳은 안보이게 -> 클리어하고 add
      (markers.markerlist).add(currentMarker(cordinate, id, context,
          _customInfoWindowController, mymarkers, _scaffoldKey, markerIcons));
    });
  } //추가 : 현재 bottom modal 창에서 북마크 추가를 해도 마커가 없어지지 않음! clear 해줘야 할 듯.

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    final med = MediaQuery.of(context).size;

    debugPrint('build ===================');

    return Scaffold(
      key: _scaffoldKey,
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
