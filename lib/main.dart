import 'package:flutter/material.dart';
import 'home/home-page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is a User Page'),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    UserPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

     var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device

    
    AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 255, 155, 155),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.backspace),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {},
        ),
        SizedBox(width: 20.0 / 2)
      ],
    );
  }
    return Scaffold(
      appBar: buildAppBar(),
      body:Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .20,
            decoration: BoxDecoration(
              color: Color(0xFFF5CEB8),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
                )
            )
          )]
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 255, 128, 122),
        onTap: _onItemTapped,
      ),
    );

    
  }
}
