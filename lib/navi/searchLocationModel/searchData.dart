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
      margin: EdgeInsets.only(left:20, right: 20),
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
        child: Container(
          padding: const EdgeInsets.all(30.0),
           decoration: BoxDecoration(
              color: Color(0xffFD8B8B),
              // border: Border.all( 
              //   width: 10,
              //   color: Colors.orange, 
              //    ),
              borderRadius: BorderRadius.circular(28),
    ), //  POINT: BoxDecoration
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(widget.searchData!.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white
              ),
            ),
            SizedBox(height: 20.0),
            Text(widget.searchData!.address,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.white
              ),
            )
          ],
        ),
      )) : Center(child: Text("어디로 가시겠어요?")),

    );
    
  }

}

