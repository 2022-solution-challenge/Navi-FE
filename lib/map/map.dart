import 'package:flutter/material.dart';

class MapApp extends StatelessWidget{
  const MapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        children: <Widget>[
          Text("Where to Go? SEARCH"),
          SizedBox(
            height: 20.0,
          ),
          ToGoInput()
        ],
      ),
    );
  }
}


//Make StateFul widget
class ToGoInput extends StatefulWidget{
  const ToGoInput({Key? key}) : super(key: key);

  @override
  State<ToGoInput> createState() => ToGoInputState();
}

class ToGoInputState extends State<ToGoInput>{

  final textController = TextEditingController();
  String textToFind = "";
  @override
  void initState(){

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView(
        children : [
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
                },
                child: Text("Find"),
              ),
            ],
          ),
        ]
      ),
    );
  }
}