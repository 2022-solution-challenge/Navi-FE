import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart';
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';
import './parseHtml.dart';


Future<List<Room>> getRoom() async {
  String url = "https://solution-challenge-hb6fjqbi3q-du.a.run.app/chat/rooms";

  http.Response response = await http.get(
    Uri.parse(url),
  );

  if(response.statusCode == 200){
    var document = parse(response.body);
    var elements = document.getElementsByTagName('a')
          .where((e) => e.attributes.containsKey('href'))
          .map((e) => e.attributes['href'])
          .toList();
    List<String> elementNames = document.getElementsByTagName('a')
          .where((element) => element.innerHtml.isNotEmpty)
          .map((e) => e.innerHtml)
          .toList();

    List<Room> roomList = [];
    for(int i = 0 ; i < elementNames.length ; i++){
      roomList.add(
        Room.fromMap(
            elements[i].toString(),
            elementNames[i].toString()
        )
      );
    }
    return roomList;
  }
  throw Exception("Room get error");
}
