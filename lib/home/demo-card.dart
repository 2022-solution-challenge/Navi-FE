import 'package:flutter/material.dart';
import 'items.dart';

class DemoCard extends StatelessWidget {

  final Item item;

  String? showName;
  String? showDiscription;

  DemoCard(this.item){
    this.showDiscription =  item.description;
    this.showName = item.name;
    
  }

  // static final Shadow _shadow =
  //     Shadow(offset: Offset(2.0, 2.0), color: Colors.black26);
  final TextStyle _style = TextStyle(color: Color.fromARGB(255, 0, 0, 0));

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        color: Colors.white, //item.color.withOpacity(1)
        child: Container(
            constraints: BoxConstraints.expand(height: 200, width: 100),
            child: RawMaterialButton(
              onPressed: () {           

              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(card: this.item),
              ),

            );},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(item.name, style: _style.copyWith(fontSize: 30)),
                        Icon(item.icon, color: Colors.white70, size: 30),
                      ])
                ],
              ),
            )));
  }
}

class DetailScreen extends StatelessWidget {
  // Todo를 들고 있을 필드를 선언합니다.
  final Item card;

  // 생성자는 Todo를 인자로 받습니다.
  DetailScreen({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UI를 그리기 위해 Todo를 사용합니다.
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

