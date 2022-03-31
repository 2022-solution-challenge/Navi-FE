import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'record.dart';

class MyRecord extends StatelessWidget {
  MyRecord(this.item);
  final Record item;

  // static final Shadow _shadow =
  //     Shadow(offset: Offset(2.0, 2.0), color: Colors.black26);
  final TextStyle _style = TextStyle(color: Color.fromARGB(179, 52, 50, 50));

  @override
  Widget build(BuildContext context) {
    return Container(
       height: 85,
       margin: EdgeInsets.only(bottom: 13),
            padding:EdgeInsets.only(left: 10, top: 12, bottom: 12, right: 10),
            decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
            child: RawMaterialButton(
              onPressed: () {},
              child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 29,
                            top: 5,
                            child: Text(
                              item.date,
                              style: GoogleFonts.inter(
                                  fontSize: 15,),
                            ),
                          ),
                          Positioned(
                            right: 21,
                            top: 5,
                            child: Container(
                              height: 20,
                              width: 110,
                              decoration: BoxDecoration(
                               color: Color.fromARGB(179, 255, 92, 92),
                               borderRadius: BorderRadius.circular(15)),
                              child: Text('Arrived Safety ', textAlign: TextAlign.center, style: GoogleFonts.inter(color:Colors.white)),
                              
                              ),
                          ),
                          Positioned(
                            left: 29,
                            bottom: 5,
                            child: Text(
                              item.destination,
                              style: GoogleFonts.inter(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Positioned(
                            right: 21,
                            bottom: 5,
                            child: Text(
                              item. timeInterval,
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,),
                            ),
                          )
                        ],
              )  
            ));
  }
}
