import 'dart:convert';

import 'package:flutter/material.dart';
import './place.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  final String = dotenv.env('GOOGLE_PLACE_API');
  //init에서 http결과 가져오기
  //https://developers.google.com/maps/documentation/places/web-service/search-text?hl=ko
  Future<Place> fetchPost() async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/textsearch/json'
        + '?query=$data%20in%20Sydney'
        + '&key=YOUR_API_KEY'    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
      return Place.fromJson(json.decode(response.body));
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('Failed to load post');
    }
  }
  //얘를 또 parse 해야함


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