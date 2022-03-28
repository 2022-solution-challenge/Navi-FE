import 'package:flutter/material.dart';

class ConnectMap extends StatefulWidget{


  const ConnectMap({Key? key, required this.mainurl}) : super(key: key);

  final String mainurl;

  @override
  State<ConnectMap> createState() => ConnectMapState();
}

class ConnectMapState extends State<ConnectMap>{
  @override
  Widget build(BuildContext context){
    return Container(
      child: Text(widget.mainurl),
    );
  }
}