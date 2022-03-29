import 'dart:io';
import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
// page
import 'getRoom.dart';
import 'parseHtml.dart';
import 'connectMap.dart';

class ConnectContainer extends StatefulWidget{
  late String auth;
  ConnectContainer({Key? key, required this.auth}) : super(key: key);

  @override
  State<ConnectContainer> createState() => ConnectContainerState();
}

class ConnectContainerState extends State<ConnectContainer>{

  late FToast fToast;
  final textController = TextEditingController();

  makeRoom(String roomName) async {
    String url = "https://solution-challenge-hb6fjqbi3q-du.a.run.app/chat/rooms?name=";

    var headers =<String,String>{
      HttpHeaders.authorizationHeader : widget.auth,
      // 'Content-Type' : 'text/html'
    };

    url = url + roomName.toString();

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      // body: param
    );
    debugPrint(response.statusCode.toString());
    if (response.statusCode < 400){
      debugPrint("make room");
      debugPrint(response.headers.toString());
      showToast("you were added");
      setState(() {
        getRoom()
            .then((value) =>
            setState((){
              roomList = value;
            })
        );
      });
    }
    if (response.statusCode >= 400){
      showToast("There was an error");
    }
  }
  
  void showToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      fontSize: 14,
      backgroundColor: Colors.red.shade400,
    );
  }
  

  List<Room>? roomList;
  @override
  void initState(){
    super.initState();
    fToast = FToast();
    fToast.init(context);
    
    getRoom()
        .then((value) =>
        setState((){
          roomList = value;
        })
    );
    debugPrint(roomList.toString());
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "Find your child",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
              Row(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                      labelText: "make your room"
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: OutlinedButton(
                      child: Text("Make"),
                      onPressed: (){
                        if(textController.text != ""){
                          makeRoom(textController.text);
                        }
                      },
                    )
                  ),
                ],
              ),
              ConnectMain(roomList: roomList)
            ],
          ),
        ),

      ),
    );
  }
}


class ConnectMain extends StatefulWidget{

  ConnectMain({Key? key, required this.roomList}) : super(key: key);
  List<Room>? roomList;

  @override
  State<ConnectMain> createState() => ConnectMainState();
}


class ConnectMainState extends State<ConnectMain>{



  @override
  Widget build(BuildContext context){
    if(widget.roomList != null){
      return Container(
        margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: const Color.fromARGB(179, 255, 92, 92),
        ),
        child: Center(
          child: Column(
            children: widget.roomList!.map((e) =>
                GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConnectMap(
                            mainurl: e.url,
                          )
                        )
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          e.name,
                          style: const TextStyle(
                            fontSize: 20,
                              color: Colors.white70,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        )
                      ],
                    )
                )
            ).toList(),
          ),
        ),
      );
    }
    else{
      return Column(
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          Text(
            "Now loading",
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          )
        ],
      );
    }
  }
}