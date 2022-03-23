import 'package:flutter/cupertino.dart';
import 'package:flutter_test_app/navi/get_accidet_list.dart';

class AccidentMarkerList {
  final List<AccidentMarker> accidents;

  AccidentMarkerList({
    required this.accidents,
  });

  factory AccidentMarkerList.fromJson(List<dynamic> parsedJson) {
    List<AccidentMarker> accidents = [];
    accidents = parsedJson.map((i) => AccidentMarker.fromJson(i)).toList();

    return AccidentMarkerList(accidents: accidents);
  }
}

class AccidentMarker {
  final int? id;
  final String? severity;
  final double startLat;
  final double startLng;
  final double endLat;
  final double endLng;
  final double distance; //double로 바꿔야 할 수도!
  final String? description;
  final String? state;

  AccidentMarker(
      {this.id,
      this.severity,
      required this.startLat,
      required this.startLng,
      required this.endLat,
      required this.endLng,
      required this.distance,
      this.description,
      this.state});

  factory AccidentMarker.fromJson(Map<String, dynamic> json) {
    if (json['distance'] == 0) {
      json['distance'] = 0.0;
    }
    return AccidentMarker(
      id: json['id'],
      severity: json['severity'],
      startLat: json['startLat'],
      startLng: json['startLng'],
      endLat: json['endLat'],
      endLng: json['endLng'],
      distance: json['distance'],
      description: json['description'],
      state: json['state'],
    );
  }
}

//dummy list, should call api to show this values.

Future<List<AccidentMarker>> testAccident() async {

  debugPrint('===========call APIS, ${GetAccidentList().getAccident().runtimeType}==========');
  
  List<dynamic> temp = await GetAccidentList().getAccident();
  debugPrint('===========END==========');
  final testvar = AccidentMarkerList.fromJson(temp);

  return testvar.accidents;
}

List<AccidentMarker> accidnetItems = [
  AccidentMarker.fromJson({
    "id": 5,
    "severity": "2",
    "startLat": 38.518811,
    "startLng": -121.101664,
    "endLat": 38.518811,
    "endLng": -121.101664,
    "distance": 0.0,
    "description": "Between Latrobe Rd/Indio Dr and Latrobe Rd - Accident.",
    "state": "CA"
  }),
  AccidentMarker.fromJson({
    "id": 4,
    "severity": "2",
    "startLat": 38.528811,
    "startLng": -121.101664,
    "endLat": 38.528811,
    "endLng": -121.101664,
    "distance": 0.17,
    "description": "At I-80/I-580 Northern Split - Accident.",
    "state": "CA"
  }),
];
