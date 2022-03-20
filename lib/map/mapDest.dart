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
      home: Text(
        '$dest'
      ),
    );
  }
}

