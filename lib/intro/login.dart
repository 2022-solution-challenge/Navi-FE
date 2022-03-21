import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'dart:convert' show jsonDecode;

import 'package:flutter/material.dart';
import 'register.dart';
import 'package:flutter_test_app/main.dart';

Future<void> signIn() async {
  debugPrint('==========get result ============');
  // App specific variables
  final googleClientId =
      'cliant_key';
  final callbackUrlScheme =
      'login_url';

  // Construct the url
  final url = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
    'client_id': googleClientId,
    'redirect_uri': '$callbackUrlScheme',
    'response_type': 'code',
    'scope': 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile',
  });

  debugPrint('==========here is url ${url.toString()}============');

    // Present the dialog to the user
  final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: callbackUrlScheme);
 

  // // Extract code from resulting url
  final code = Uri.parse(result).queryParameters['code'];

  debugPrint('==========get result from url ${result}============');
  debugPrint('==========get result from url ${code}============');

  
  // // Use this code to get an access token
  // final response = await http
  //     .post(Uri.parse('https://www.googleapis.com/oauth2/v4/token'), body: {
  //   'client_id': googleClientId,
  //   'redirect_uri': '$callbackUrlScheme
  //   'grant_type': 'authorization_code',
  //   'code': code,
  // });

  // // Get the access token from the response
  // final accessToken = jsonDecode(response.body)['username'] as String;
}

class LoginScreen extends StatelessWidget {
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
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "LOGIN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(labelText: "Username"),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                "Forgot your password?",
                style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyStatefulWidget()));
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0),
                  //side: BorderSide(color: Colors.red)
                ))),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "LOGIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
                              
            ElevatedButton(
              onPressed: () => {signIn()},
              child: Text('google Login')),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()))
                },
                child: Text(
                  "Don't Have an Account? Sign up",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
