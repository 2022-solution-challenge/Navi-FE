import 'package:flutter/material.dart';

class MapDest extends StatelessWidget{
  const MapDest({Key? key, @required this.dest}) : super(key: key);
  final String? dest;
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchData(data: dest,),
    );
  }
}


//검색 결과 보여주는
class SearchData extends StatelessWidget{
  const SearchData({Key? key, @required this.data}) : super(key: key);
  final String? data;
  //init에서 http결과 가져오기
  //https://developers.google.com/maps/documentation/places/web-service/search-text?hl=ko

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          Text("$data")
        ],
      )
    );
  }
}