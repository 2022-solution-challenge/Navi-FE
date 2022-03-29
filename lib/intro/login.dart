// import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'package:flutter_test_app/main.dart';



class LoginScreen extends StatefulWidget{


  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  late String auth;
  final LocalStorage storage = new LocalStorage('local_key');

  late FToast fToast;

  late String userName;
  late String passWord;

  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  @override
  void initState(){
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void showToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      fontSize: 14,
      backgroundColor: Colors.red.shade400,
    );
  }

  //로그인 코드
  _login() async {
    //로그인 파라미터 username/password
    var param = <String, String>{
      "password": passWordController.text,
      "username": userNameController.text
    };


    String url = "https://solution-challenge-hb6fjqbi3q-du.a.run.app/users/login";

    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String,String>{
        'Content-Type' : 'application/json',
      },
      body: jsonEncode(param)
    );
    debugPrint(response.statusCode.toString());
    if(response.statusCode == 200){
      var list = jsonDecode(response.body);
      String token = list['access_token'];
      storage.setItem('token', token);
      auth = token.toString();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MainApp(auth : auth)));
      return;
    }
    showToast("please check your name and password");
    return;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                "LOGIN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFD8B8B),
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: userNameController,
                decoration: const InputDecoration(
                    labelText: "Username"
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: passWordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: const Text(
                "Forgot your password?",
                style: TextStyle(fontSize: 12, color: Color(0xffFD8B8B)),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: () {

                  if(userNameController.text == "") {
                    showToast("please enter your name");
                    return;
                  }
                  if(passWordController.text == ""){
                    showToast("please enter your password");
                    return;
                  }
                  _login();

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffFD8B8B)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0),
                  //side: BorderSide(color: Colors.red)
                ))),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),

                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    "LOGIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen())),
                },
                child: const Text(
                  "Don't Have an Account? Sign up",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFD8B8B)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
