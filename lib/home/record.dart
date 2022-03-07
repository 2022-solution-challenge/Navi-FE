import 'package:flutter/material.dart';

class Record {
  String date;
  String destination;
  MaterialColor color;
  String timeInterval;
  Record(this.date, this.destination, this.color, this.timeInterval);
}

List<Record> records = [
  Record('2020. 10. 01', "승일초등학교", Colors.amber, '8:00-9:00'),
  Record('2020. 10. 02', "꿈빛누리학원", Colors.cyan, '8:00-9:00'),
  Record('2020. 10. 02', "피아노학원", Colors.indigo, '8:00-9:00'),
  Record('2020. 10. 02', "장독대", Colors.green, '8:00-9:00'),
  Record('2020. 10. 02', "GIST", Colors.pink, '8:00-9:00'),
  Record('2020. 10. 02', "떡볶이집", Colors.blue, '8:00-9:00')
];
