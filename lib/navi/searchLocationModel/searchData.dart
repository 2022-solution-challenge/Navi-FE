import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:flutter/material.dart';
import 'searchDataModel.dart';
import '../mapModel/mapDest.dart';

class SearchResult extends StatefulWidget{

  SearchResult({Key? key, required this.searchData, required this.isLoaded}) : super(key: key);
  bool isLoaded;
  SearchData? searchData;


  @override
  State<SearchResult> createState() => SearchResultState();
}

class SearchResultState extends State<SearchResult>{

  @override
  void initState(){

  }

  @override
  Widget build(BuildContext context){
    return Container(
      child: widget.isLoaded?
      GestureDetector(
        onTap: (){
          if(widget.isLoaded){
            Navigator.push(
              context,
              MaterialPageRoute(
                //페이지 이동하면서 목적지 장소 위치 전달하기

                  builder: (context) => NaviMainApp(DestLocation: widget.searchData!.location)
              ),
            );
          }
        },
        child: Column(
          children: <Widget>[
            Text(widget.searchData!.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 40.0),
            Text(widget.searchData!.address,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            )
          ],
        ),
      ) : Text(""),

    );
    
  }

}

