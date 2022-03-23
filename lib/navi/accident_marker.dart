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

List<AccidentMarker> testAccident() {

  final testvar = AccidentMarkerList.fromJson([
    {
      "id": 1,
      "severity": "3",
      "startLat": 38.82584,
      "startLng": -120.029214,
      "endLat": 38.827194,
      "endLng": -120.030632,
      "distance": 0.121,
      "description":
          "Between Twin Bridges Tract and South Lake Tahoe - Accident.",
      "state": "CA"
    },
    {
      "id": 2,
      "severity": "2",
      "startLat": 37.358209,
      "startLng": -121.840017,
      "endLat": 37.361596,
      "endLng": -121.842044,
      "distance": 0.259,
      "description": "Between Capitol Expy and Alum Rock Ave - Accident.",
      "state": "CA"
    },
    {
      "id": 3,
      "severity": "3",
      "startLat": 37.881943,
      "startLng": -122.307987,
      "endLat": 37.885882,
      "endLng": -122.308878,
      "distance": 0.276,
      "description": "At I-80/I-580 Northern Split - Accident.",
      "state": "CA"
    },
    {
      "id": 4,
      "severity": "2",
      "startLat": 37.881038,
      "startLng": -122.307788,
      "endLat": 37.883458,
      "endLng": -122.308366,
      "distance": 0.17,
      "description": "At I-80/I-580 Northern Split - Accident.",
      "state": "CA"
    },
    {
      "id": 5,
      "severity": "2",
      "startLat": 38.518811,
      "startLng": -121.101664,
      "endLat": 38.518811,
      "endLng": -121.101664,
      "distance": 0.0,
      "description": "Between Latrobe Rd/Indio Dr and Latrobe Rd - Accident.",
      "state": "CA"
    },
    {
      "id": 6,
      "severity": "2",
      "startLat": 38.518811,
      "startLng": -121.101664,
      "endLat": 38.518811,
      "endLng": -121.101664,
      "distance": 0.0,
      "description": "Between Latrobe Rd and Latrobe Rd/Indio Dr - Accident.",
      "state": "CA"
    },
    {
      "id": 7,
      "severity": "2",
      "startLat": 36.9903,
      "startLng": -119.71146,
      "endLat": 36.99046,
      "endLng": -119.71138,
      "distance": 0.012,
      "description": "At North Fork Rd - Overturned vehicle.",
      "state": "CA"
    },
    {
      "id": 8,
      "severity": "2",
      "startLat": 37.42592,
      "startLng": -122.09879,
      "endLat": 37.43042,
      "endLng": -122.10352,
      "distance": 0.405,
      "description":
          "At San Antonio Rd/Exit 400B/Exit 400C - Accident. Left lane blocked.",
      "state": "CA"
    },
    {
      "id": 9,
      "severity": "2",
      "startLat": 37.75745,
      "startLng": -122.21131,
      "endLat": 37.75085,
      "endLng": -122.20549,
      "distance": 0.556,
      "description": "At 66th Ave - Accident. Center lane blocked.",
      "state": "CA"
    },
    {
      "id": 10,
      "severity": "2",
      "startLat": 37.31648,
      "startLng": -121.96746,
      "endLat": 37.3181,
      "endLng": -121.9781,
      "distance": 0.595,
      "description": "At Saratoga Ave - Accident. Left lane blocked.",
      "state": "CA"
    },
    {
      "id": 11,
      "severity": "2",
      "startLat": 37.44415,
      "startLng": -122.2688,
      "endLat": 37.44403,
      "endLng": -122.2593,
      "distance": 0.521,
      "description": "At Farm Hill Blvd - Accident. Left lane blocked.",
      "state": "CA"
    },
    {
      "id": 12,
      "severity": "2",
      "startLat": 37.71981,
      "startLng": -121.65943,
      "endLat": 37.71814,
      "endLng": -121.66535,
      "distance": 0.344,
      "description": "At Flynn Rd - Accident. Left lane blocked.",
      "state": "CA"
    },
    {
      "id": 13,
      "severity": "2",
      "startLat": 37.827434,
      "startLng": -122.291037,
      "endLat": 37.827961,
      "endLng": -122.292173,
      "distance": 0.072,
      "description": "At Cypress St - Accident. Left lane blocked.",
      "state": "CA"
    },
    {
      "id": 14,
      "severity": "2",
      "startLat": 37.589091,
      "startLng": -122.3599,
      "endLat": 37.588195,
      "endLng": -122.358077,
      "distance": 0.117,
      "description":
          "Between Airport Blvd/Broadway/Exit 419B and Anza Blvd/Exit 419A - Accident. Left lane blocked.",
      "state": "CA"
    },
    {
      "id": 15,
      "severity": "2",
      "startLat": 37.377536,
      "startLng": -121.945376,
      "endLat": 37.377375,
      "endLng": -121.944519,
      "distance": 0.048,
      "description": "At De La Cruz Blvd - Accident.",
      "state": "CA"
    },
    {
      "id": 16,
      "severity": "2",
      "startLat": 37.74508,
      "startLng": -122.40493,
      "endLat": 37.74705,
      "endLng": -122.40378,
      "distance": 0.15,
      "description": "Ramp to Army St/Potrero Ave - Accident.",
      "state": "CA"
    },
    {
      "id": 17,
      "severity": "2",
      "startLat": 38.4498,
      "startLng": -122.6878,
      "endLat": 38.45853,
      "endLng": -122.67479,
      "distance": 0.927,
      "description": "At Mission Blvd - Accident.",
      "state": "CA"
    },
    {
      "id": 18,
      "severity": "2",
      "startLat": 37.886875,
      "startLng": -122.309331,
      "endLat": 37.886492,
      "endLng": -122.309294,
      "distance": 0.027,
      "description": "At I-80/I-580 Northern Split - Accident.",
      "state": "CA"
    },
    {
      "id": 19,
      "severity": "2",
      "startLat": 37.616444,
      "startLng": -122.157178,
      "endLat": 37.57453,
      "endLng": -122.26153,
      "distance": 6.405,
      "description": "At San Mateo Bridge - Accident.",
      "state": "CA"
    },
    {
      "id": 20,
      "severity": "3",
      "startLat": 38.00979,
      "startLng": -122.02371,
      "endLat": 38.0041,
      "endLng": -122.04114,
      "distance": 1.027,
      "description": "At CA-242 - Accident. use left lane.",
      "state": "CA"
    },
    {
      "id": 21,
      "severity": "2",
      "startLat": 37.895515,
      "startLng": -122.308355,
      "endLat": 37.895919,
      "endLng": -122.308522,
      "distance": 0.029,
      "description": "At Cleveland Ave - Accident. Right lane blocked.",
      "state": "CA"
    },
    {
      "id": 22,
      "severity": "2",
      "startLat": 37.891932,
      "startLng": -122.063207,
      "endLat": 37.892295,
      "endLng": -122.063969,
      "distance": 0.049,
      "description": "At CA-24/Olympic Blvd - Accident. Right lane blocked.",
      "state": "CA"
    },
    {
      "id": 23,
      "severity": "2",
      "startLat": 37.85139,
      "startLng": -122.29956,
      "endLat": 37.84527,
      "endLng": -122.29817,
      "distance": 0.43,
      "description": "At CA-13/Ashby Ave/Bay St - Accident.",
      "state": "CA"
    },
    {
      "id": 24,
      "severity": "2",
      "startLat": 38.51928,
      "startLng": -122.773446,
      "endLat": 38.518582,
      "endLng": -122.772606,
      "distance": 0.066,
      "description": "At Mark West Springs Rd - Accident.",
      "state": "CA"
    },
    {
      "id": 25,
      "severity": "3",
      "startLat": 37.556444,
      "startLng": -121.950327,
      "endLat": 37.553954,
      "endLng": -121.946391,
      "distance": 0.276,
      "description": "At Mackintosh St - Accident.",
      "state": "CA"
    },
    {
      "id": 26,
      "severity": "2",
      "startLat": 38.500342,
      "startLng": -121.431106,
      "endLat": 38.501275,
      "endLng": -121.431546,
      "distance": 0.069,
      "description":
          "Between Florin Rd and Elder Creek Rd/47th Ave - Accident.",
      "state": "CA"
    },
    {
      "id": 27,
      "severity": "3",
      "startLat": 37.554454,
      "startLng": -121.946955,
      "endLat": 37.556542,
      "endLng": -121.950253,
      "distance": 0.231,
      "description": "At Las Palmas Ave - Accident.",
      "state": "CA"
    },
    {
      "id": 28,
      "severity": "2",
      "startLat": 37.74987,
      "startLng": -122.20439,
      "endLat": 37.75617,
      "endLng": -122.20994,
      "distance": 0.53,
      "description": "At 66th Ave - Accident.",
      "state": "CA"
    },
    {
      "id": 29,
      "severity": "2",
      "startLat": 38.59486,
      "startLng": -121.44422,
      "endLat": 38.59689,
      "endLng": -121.44345,
      "distance": 0.146,
      "description": "At Exposition Blvd - Accident.",
      "state": "CA"
    },
    {
      "id": 30,
      "severity": "2",
      "startLat": 37.854629,
      "startLng": -122.217305,
      "endLat": 37.861926,
      "endLng": -122.209211,
      "distance": 0.67,
      "description": "At Caldecott Tunnel - Accident.",
      "state": "CA"
    }
  ]);

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
