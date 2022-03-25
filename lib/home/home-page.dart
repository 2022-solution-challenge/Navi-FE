import 'package:flutter/material.dart';
import 'demo-card.dart';
import 'items.dart';
import 'record-holder.dart';
import 'record.dart';
import 'package:google_fonts/google_fonts.dart';

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
  return Container(
     height: 100,
     width: 344,
     margin: EdgeInsets.only(right: 10, left:10, top:10),
     decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: Color.fromARGB(255, 195, 17, 17),
                      ),
     child: Stack(
       children: <Widget>[
            // Positioned(
            //   child: SvgPicture.asset(cards[index].cardElementTop),
            // ),
            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child:
            //       SvgPicture.asset(cards[index].cardElementBottom),
            // ), 사진을 넣는 부분
            Positioned(
              left: 29,
              top: 60,
              child: Text(
                "Connect with parents",
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
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
          ]
          )
        );
  
  // Card(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
  //     color: Colors.purple.withOpacity(1),
  //     child: Container(
  //         constraints: const BoxConstraints.expand(height: 80, width: 300),
  //         child: const Center(
  //           child: Text('부모 등록'),
  //         )));
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

Widget _whereToGo() {
  List<DemoCard> _cards = items.map((Item _item) => DemoCard(_item)).toList();

  return  
  Container(
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

/* class WhereToGo extends StatelessWidget {
  final List<DemoCard> cards;

  WhereToGo({Key? key, required this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(card: cards[index]),
              ),
            );
          },
        );
      },
    );
  }
} */
