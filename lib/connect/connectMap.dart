import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
// import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:html/dom_parsing.dart';
import 'package:http/http.dart' as http;
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ConnectMap extends StatefulWidget{


  const ConnectMap({Key? key, required this.mainurl}) : super(key: key);

  final String mainurl;

  @override
  State<ConnectMap> createState() => ConnectMapState();
}

class ConnectMapState extends State<ConnectMap>{

  late var elements;

  void getChat() async {
    String url = "https://solution-challenge-hb6fjqbi3q-du.a.run.app/";
    url = url + widget.mainurl;
    debugPrint(url.toString());
    http.Response response = await http.get(
      Uri.parse(url),
    );

    var document = parse(response.body);
    var newElements = document.getElementsByTagName('il')
        .where((element) => element.innerHtml.isNotEmpty)
        .map((e) => e.innerHtml).toList();
    setState(() {
      elements = newElements;
      debugPrint(newElements.toString());
    });
  }

  @override
  void initState(){
    getChat();
  }
  // void onConnect(StompFrame frame) {
  //   stompClient.subscribe(
  //     destination: '/topic/stomp/chat/' + widget.mainurl ,
  //     callback: (frame) {
  //       var document = parse(frame.body!);
  //       // List<dynamic>? result = json.decode(frame.body!);
  //       var elements = document.getElementsByClassName("chat_box")
  //           .where((element) => element.innerHtml.isNotEmpty)
  //           .map((e) => e.innerHtml).toList();
  //
  //       elements.add(frame.body!);
  //       // print(result);
  //     },
  //   );
  //
  //   Timer.periodic(Duration(seconds: 10), (_) {
  //     stompClient.send(
  //       destination: '/app/test/endpoints',
  //       body: json.encode({'a': 123}),
  //     );
  //   });
  // }
  //
  // final stompClient = StompClient(
  //   config: StompConfig(
  //     url: 'ws://localhost:8080',
  //     onConnect: onConnect,
  //     beforeConnect: () async {
  //       print('waiting to connect...');
  //       await Future.delayed(Duration(milliseconds: 200));
  //       print('connecting...');
  //     },
  //     onWebSocketError: (dynamic error) => print(error.toString()),
  //     stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
  //     webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
  //   ),
  // );

  @override
  Widget build(BuildContext context){
    return Container(
      child: const Text(
        "hello"
      ),
    );
  }
}