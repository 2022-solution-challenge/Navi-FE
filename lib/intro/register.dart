import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login.dart';
import 'package:http/http.dart' as  http;

class RegisterScreen extends StatefulWidget{

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}
class RegisterScreenState extends State<RegisterScreen> {

  late FToast fToast;


  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

  //회원가입 코드
  _signUp() async {
    String url = "https://solution-challenge-hb6fjqbi3q-du.a.run.app/users";

    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "email" : emailController.text,
        "password" : passwordController.text,
        "phoneNumber" : numberController.text,
        "username" : nameController.text
      }),
    );

    debugPrint(nameController.text);
    debugPrint(passwordController.text);
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Text(
              "REGISTER",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2661FA),
                fontSize: 36
              ),
              textAlign: TextAlign.left,
            ),
          ),

          SizedBox(height: size.height * 0.01),

          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name"
              ),
            ),
          ),

          SizedBox(height: size.height * 0.01),

          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: numberController,
              decoration: const InputDecoration(
                labelText: "Mobile Number"
              ),
            ),
          ),

          SizedBox(height: size.height * 0.01),

          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email"
              ),
            ),
          ),

          SizedBox(height: size.height * 0.01),

          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Password"
              ),
              obscureText: true,
            ),
          ),

          SizedBox(height: size.height * 0.03),

          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                if(nameController.text == ""){
                  showToast("please enter your name");
                  return;
                }
                if(numberController.text == ""){
                  showToast("please enter your phone number");
                  return;
                }
                if(emailController.text == ""){
                  showToast("please enter your email");
                  return;
                }
                if(passwordController.text == ""){
                  showToast("please enter your password");
                  return;
                }
                _signUp();

              },
              style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                        //side: BorderSide(color: Colors.red)
                      )
                    )
                  ),
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 136, 34),
                      Color.fromARGB(255, 255, 177, 41)
                    ]
                  )
                ),
                padding: const EdgeInsets.all(0),
                child: const Text(
                  "SIGN UP",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),

          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: GestureDetector(
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()))
              },
              child: const Text(
                "Already Have an Account? Sign in",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2661FA)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}