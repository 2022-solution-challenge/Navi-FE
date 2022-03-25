import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './searchDataModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SearchRepository{

  static const String _baseUrl =
    'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry';

  final Dio _dio;
  final String APIKEY = dotenv.get('GOOGLE_PLACE_API');

  SearchRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<SearchData> getInfomation({
    required String name,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'input' : '${name}',
        'inputtype' :'textquery',
        'key' : APIKEY
      }
    );
    debugPrint("api called");


    if(response.statusCode == 200){
      if(SearchData.fromMap(response.data) == null){
        throw new Exception('Error');
      }
      return SearchData.fromMap(response.data);
      
    }else{
      throw new Exception('response Error');
    }
  }
}