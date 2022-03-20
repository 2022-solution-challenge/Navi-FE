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
      home: SearchData(),
    );
  }
}


//검색 결과 보여주는
class SearchData extends StatelessWidget{
  const SearchData({Key? key}) : super(key: key);

  //init에서 http결과 가져오기

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Text("dest"),
    );
  }
}