import 'package:flutter/material.dart';
import 'package:flutter_test_app/navi/naviMain.dart';
import 'items.dart';

class DemoCard extends StatelessWidget {
  final Item item;

  String? showName;
  String? showDiscription;

  DemoCard(this.item) {
    this.showDiscription = item.description;
    this.showName = item.name;
  }

  // static final Shadow _shadow =
  //     Shadow(offset: Offset(2.0, 2.0), color: Colors.black26);
  final TextStyle _style = TextStyle(color: Color.fromARGB(255, 0, 0, 0));

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 20),
        width: 90,
        height: 123,
        decoration: BoxDecoration(
          // boxShadow: const [
          //         BoxShadow(
          //           color: Color.fromARGB(255, 226, 226, 226),
          //         blurRadius: 10,
          //         spreadRadius: 5,
          //         offset: Offset(2.0, 2.0),
          //   )
          // ],
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: RawMaterialButton(
          onPressed: () {
            if (item.name == "Add") {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Scaffold(
                      body: 
                      NaviApp()
                      
                      )),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(card: this.item)),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(item.icon,
                        color: Color.fromARGB(179, 255, 92, 92), size: 30),
                    SizedBox(
                      height: 9,
                    ),
                    Text(item.name,
                        textAlign: TextAlign.center,
                        style: _style.copyWith(fontSize: 15)),
                  ])
            ],
          ),
        ));
  }
}

class DetailScreen extends StatelessWidget {
  // Todo??? ?????? ?????? ????????? ???????????????.
  final Item card;

  // ???????????? Todo??? ????????? ????????????.
  DetailScreen({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UI??? ????????? ?????? Todo??? ???????????????.
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(card.description),
      ),
    );
  }
}
