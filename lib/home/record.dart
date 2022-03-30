import 'package:flutter/material.dart';

class Record {
  String date;
  String destination;
  MaterialColor color;
  String timeInterval;
  Record(this.date, this.destination, this.color, this.timeInterval);
}

List<Record> records = [
  Record('2020. 10. 01', "Sengil School", Colors.amber, '8:17-8:32'),
  Record('2020. 10. 02', "Academy", Colors.cyan, '12:42-12:54'),
  Record('2020. 10. 02', "Piano school", Colors.indigo, '8:00-9:00'),
  Record('2020. 10. 02', "Market", Colors.green, '8:00-9:00'),
  Record('2020. 10. 02', "GIST", Colors.pink, '8:00-9:00'),
  Record('2020. 10. 02', "Noodle tree", Colors.blue, '8:00-9:00')
];
