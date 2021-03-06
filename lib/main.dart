import 'package:flutter/material.dart';
import 'home/home-page.dart';
import 'navi/naviMain.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'map/map.dart';
import 'intro/login.dart';
import 'dart:developer';

//main 함수에 env파일 추가
void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: LoginScreen(),
    );
  }
}

//MyStatefulWidget()

class MainApp extends StatelessWidget{

  late String auth;
  MainApp({Key? key, required this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: WillPopScope(
        child: MyStatefulWidget(auth : auth),
        onWillPop: () {
          return Future(() => false);
        },
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  late String auth;
  MyStatefulWidget({Key? key, required this.auth}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  late String nowAuth;
  late List<Widget> _widgetOptions;
  @override
  void initState(){
    nowAuth =  widget.auth;
    _widgetOptions = <Widget>[
      HomePage(auth: nowAuth),
      MapApp(),
    ];
  }
  // final List<Widget> _widgetOptions = <Widget>[
  //   HomePage(auth: nowAuth),
  //   MapApp(),
  //   UserPage(),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device

    // AppBar buildAppBar() {
    //   return AppBar(
    //     backgroundColor: Color.fromARGB(255, 255, 155, 155),
    //     elevation: 0,
    //     leading: IconButton(
    //       icon: Icon(Icons.backspace),
    //       onPressed: () {},
    //     ),
    //     actions: <Widget>[
    //       IconButton(
    //         icon: Icon(Icons.search),
    //         onPressed: () {},
    //       ),
    //       IconButton(
    //         icon: Icon(Icons.home),
    //         onPressed: () {},
    //       ),
    //       SizedBox(width: 20.0 / 2)
    //     ],
    //   );
    // }

    return Scaffold(
      // appBar: buildAppBar(),
      body: Stack(children: <Widget>[
        Container(
          height: size.height,
          color: Color.fromARGB(255, 247, 247, 247)
          // Here the height of the container is 45% of our total height
          // height: size.height * .20,
          // decoration: BoxDecoration(
          //   color: Color(0xFFF5CEB8),
          // ),
        ),
        SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: _widgetOptions.elementAt(_selectedIndex),
                )))
      ]),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color.fromARGB(255, 223, 223, 223),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: 'maps',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 255, 128, 122),
        onTap: _onItemTapped,
      ),
    );
  }
}
