import 'package:flutter/material.dart';
import 'demo-card.dart';
import 'items.dart';
import 'record-holder.dart';
import 'record.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_test_app/connect/connectMain.dart';

class HomePage extends StatelessWidget {

  HomePage({Key? key, required this.auth}) : super(key: key);
  late String auth;

  @override
  Widget build(BuildContext context) {
    return ListView(physics: const ClampingScrollPhysics(), children: <Widget>[
      _description(),
      _signUpParents(auth: this.auth),
      _whereToGo(),
      _myRecords(),
    ]);
  }
}

class _signUpParents extends StatelessWidget {

  late String auth;
  _signUpParents({Key? key, required this.auth}): super(key: key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConnectContainer(
            auth: this.auth
          ))
        );
      },
      child: Container(
          height: 100,
          width: 344,
          margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: const Color.fromARGB(179, 255, 92, 92),
          ),
          child: Stack(children: <Widget>[
            Positioned(
              left: 29,
              top: 60,
              child: Text(
                "Connect with parents",
                style: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
            const Positioned(
              right: 21,
              top: 20,
              child: Icon(Icons.arrow_right, color: Colors.white70, size: 27),
            ),
            Positioned(
              left: 29,
              top: 20,
              child: Text(
                '카드를 눌러 부모님과 연동할 수 있어요',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
              ),
            ),
          ])),
    );
  }

}

Widget _myRecords() {
  List<MyRecord> _records =
      records.map((Record _record) => MyRecord(_record)).toList();

  return Container(
      child: Column(children: <Widget>[
    Padding(
        padding: EdgeInsets.only(left: 16, bottom: 13, right: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Recent Histories',
              style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ],
        )),
    Stack(alignment: AlignmentDirectional.topStart, children: <Widget>[
      SizedBox(
        child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: _records),
      )
    ])
  ]));
}

Widget _whereToGo() {
  List<DemoCard> _cards = items.map((Item _item) => DemoCard(_item)).toList();

  int current = 0;

  return Container(
      child: Column(children: <Widget>[
    Padding(
      padding: EdgeInsets.only(left: 16, top: 30, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '길 찾아가기',
            style: GoogleFonts.inter(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ],
      ),
    ),
    Container(
        height: 123,
        child: ListView(
            padding: EdgeInsets.only(left: 5, bottom: 10, top: 10, right: 5),
            scrollDirection: Axis.horizontal,
            children: _cards)),
  ]));
}

Widget _description() {
  return Padding(
    padding: EdgeInsets.only(left: 16, bottom: 16, top:40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'for your Safety,',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Here is Navi',
          style: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    ),
  );
}
