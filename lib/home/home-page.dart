import 'package:flutter/material.dart';
import 'demo-card.dart';
import 'items.dart';
import 'record-holder.dart';
import 'record.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      _signUpParents(),
      _whereToGo(),
      _myRecords(),
    ]);
  }
}

Widget _signUpParents() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    color: Colors.purple.withOpacity(.7),
    child:Container(
            constraints: BoxConstraints.expand(height: 80, width: 300),
            child: Center(
      child: Text('부모 등록'),
    ))
  );
}

Widget _whereToGo() {
  List<DemoCard> _cards = items.map((Item _item) => DemoCard(_item)).toList();

  return Container(
      child: Column(children: <Widget>[
    Text('길 찾아가기'),
    Stack(alignment: AlignmentDirectional.topStart, children: <Widget>[
      SizedBox(
        height: 100, // constrain height
        child: ListView(scrollDirection: Axis.horizontal, children: _cards),
      )
    ])
  ]));
}

Widget _myRecords() {
  List<MyRecord> _records =
      records.map((Record _record) => MyRecord(_record)).toList();

  return Container(
      child: Column(children: <Widget>[
    Text('최근 내 기록'),
    Stack(alignment: AlignmentDirectional.topStart, children: <Widget>[
      SizedBox(
        height: 400, // constrain height
        child: ListView(scrollDirection: Axis.vertical, children: _records),
      )
    ])
  ]));
}
