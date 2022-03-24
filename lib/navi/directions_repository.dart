import 'dart:async';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './directions_model.dart';

class DirectionRepository{
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';

  final Dio _dio;
  final String APIKEY = dotenv.get('GOOGLE_PLACE_API');

  DirectionRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': APIKEY,
      }
    );

    if(response.statusCode == 200){
      if(Directions.fromMap(response.data) == null) {
        throw new Exception('Error');
      }
      return Directions.fromMap(response.data);
      
      // return Directions.fromMap(response.data);
    }else{
      throw new Exception('response error');
    }
  }
}