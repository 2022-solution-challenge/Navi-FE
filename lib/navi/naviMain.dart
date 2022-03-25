import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'mapModel/mapDest.dart';
import 'locationSearch/searchData.dart';
import 'locationSearch/searchDataModel.dart';
import 'locationSearch/searchDataRepository.dart';

class NaviApp extends StatefulWidget{
  const NaviApp({Key? key}) : super(key: key);

  @override
  State<NaviApp> createState() => NaviAppState();
}
class NaviAppState extends State<NaviApp>{
  bool isLoaded = false;
  SearchData? naviSearchData;
  void setSearchData(String query) async {

    //잘못 눌렸을 경우 대비용 null BTN
    if (query == null){
      return;
    }
    SearchData? nowData = await SearchRepository().getInfomation(name: query);
    setState(() {
      isLoaded = true;
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
            SearchResult(searchData: naviSearchData, isLoaded: isLoaded),
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
              widget.changeQuery(textToFind);
            },
            child: Text("Find"),
          ),
        ],
      ),
    );
  }
}

