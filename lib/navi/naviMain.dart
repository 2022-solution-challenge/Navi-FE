import 'dart:developer';

import 'package:flutter/material.dart';
import './mapDest.dart';
import './searchData.dart';
import './searchDataModel.dart';
import './searchDataRepository.dart';

class NaviApp extends StatefulWidget{
  const NaviApp({Key? key}) : super(key: key);

  @override
  State<NaviApp> createState() => NaviAppState();
}
class NaviAppState extends State<NaviApp>{

  SearchData? naviSearchData;
  void setSearchData(String query) async {

    //잘못 눌렸을 경우 대비용 null BTN
    if (query == null){
      return;
    }
    SearchData? nowData = await SearchRepository().getInfomation(name: query);
    setState(() {
      naviSearchData = nowData;
    });
  }

  @override
  Widget build(BuildContext context){
    return Center(
        child: Column(
          children: <Widget>[
            Text("Where to Go? SEARCH"),
            SizedBox(
              height: 20.0,
            ),
            ToGoInput(setSearchData),
            SizedBox(
              height: 40.0,
            ),
            SearchResult(searchData: naviSearchData),
          ],
        )
    );
  }
}


//Make StateFul widget
class ToGoInput extends StatefulWidget{
  const ToGoInput(this.changeQuery);

  final void Function(String) changeQuery;

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
    return Container(
      // height: 300,
      child: Row(
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
              final
            },
            child: Text("Find"),
          ),
        ],
      ),
    );
  }
}

