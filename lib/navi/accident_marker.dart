class AccidentMarker {

  final int? id;
  final String? severity;
  final double startLat;
  final double startLng;
  final double endLat;
  final double endLng;
  final double distance;
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

List<AccidentMarker> accidnetItems = [
  AccidentMarker.fromJson({
    "id": 5,
    "severity": "2",
    "startLat": 38.518811,
    "startLng": -121.101664,
    "endLat": 38.518811,
    "endLng": -121.101664,
    "distance": 0,
    "description": "Between Latrobe Rd/Indio Dr and Latrobe Rd - Accident.",
    "state": "CA"
  }),
    AccidentMarker.fromJson({
    "id": 6,
    "severity": "2",
    "startLat": 38.518811,
    "startLng": -121.101664,
    "endLat": 38.518811,
    "endLng": -121.101664,
    "distance": 0,
    "description": "Between Latrobe Rd and Latrobe Rd/Indio Dr - Accident.",
    "state": "CA"
  }),
];
