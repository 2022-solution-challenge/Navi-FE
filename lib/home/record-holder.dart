import 'package:flutter/material.dart';
import 'record.dart';

class MyRecord extends StatelessWidget {
  MyRecord(this.item);
  final Record item;

  // static final Shadow _shadow =
  //     Shadow(offset: Offset(2.0, 2.0), color: Colors.black26);
  final TextStyle _style = TextStyle(color: Color.fromARGB(179, 52, 50, 50));

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32)),
        color: Colors.white.withOpacity(.7),
        child: Container(
            constraints: BoxConstraints.expand(height: 80, width: 100),
            child: RawMaterialButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(item.date, style: _style.copyWith(fontSize: 10)),
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                            color: item.color.withOpacity(.7),
                          child:Container(
                            child: Center(
                              child: Text('안심 귀가 완료'),
                              ))
                              )
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(item.destination, style: _style.copyWith(fontSize: 30)),
                        Text(item. timeInterval, style: _style.copyWith(fontSize: 10)),
                      ])
                ],
              ),
            )));
  }
}
