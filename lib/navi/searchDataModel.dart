import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchData{
  final String address;
  final LatLng location;
  final String name;

  const SearchData({
    required this.address,
    required this.location,
    required this.name,
  });

  factory SearchData.fromMap(Map<String, dynamic> map){

    final data = Map<String, dynamic>.from(map['candidates'][0]);

    final loca = data['location'];
    final bounds = LatLng(
      loca['lat'], 
      loca['lng']
    );

    String address = data['formatted_address'];
    String name = data['name'];

    //Json parse 후 return
    return SearchData(
      address: address, 
      location: bounds, 
      name: name
    );
  }
}