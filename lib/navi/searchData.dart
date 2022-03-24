import 'dart:html';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:flutter/material.dart';
import './searchDataModel.dart';

class SearchResult extends StatefulWidget{

  const SearchResult({Key? key, required this.searchData}) : super(key: key);

  final SearchData? searchData;

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
      child:
      Text((() {
        if(searchData != null){
          return searchData.name;
        }

        return "anything but true";
      })()),
    );
    // return Text((() {
    //   if(true){
    //     return "tis true";}
    //
    //   return "anything but true";
    // })());
  }

}