import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_test_app/navi/accident_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './directions_model.dart';

class GetAccidentList{
  static const String _baseUrl =
      'https://solution-challenge-hb6fjqbi3q-du.a.run.app/';

  final Dio _dio;

  GetAccidentList({Dio? dio}) : _dio = dio ?? Dio();

  Future<List<AccidentMarker>> getAccident() async {
    final response = await _dio.get(
      _baseUrl,
      // queryParameters: {
      //   'origin': '${origin.latitude},${origin.longitude}',
      //   'destination': '${destination.latitude},${destination.longitude}',
      // }
      // 나중에 지역별 분류가 필요하다면 쿼리파라미터 추가
    );

    if(response.statusCode == 200){
      if((response.data) == null) {
        throw new Exception('Error');
      }else {
        return response.data;
      }
      // return Directions.fromMap(response.data);
    }else{
      throw new Exception('response error');
    }
  }
}