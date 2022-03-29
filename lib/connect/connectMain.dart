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
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _connectDescription(),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                      fillColor: Colors.white,
                      hoverColor: Color(0xffFD8B8B),
                      labelText: "make your room"
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: OutlinedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xffFD8B8B))),
                      child: Text("Make", style: TextStyle(color:Colors.white)),
                      onPressed: (){
                        if(textController.text != ""){
                          makeRoom(textController.text);
                        }
                      },
                    )
                  ),
                ],
              ),
             SizedBox(height: 40,),
             Center(child: Text(
          'Room List',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),),
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


Widget _connectDescription() {
  return Padding(
    padding: EdgeInsets.only(left: 16, bottom: 16, top: 60),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'find your',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Child',
          style: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    ),
  );
}