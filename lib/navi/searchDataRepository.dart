import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './searchDataModel.dart';
import 'package:http/http.dart' as http;

class SearchRepository{

  static const String _baseUrl =
    'https://maps.googleapis.com/maps/api/place/findplacefromtext/json';

  final Dio _dio;
  final String APIKEY = dotenv.get('GOOGLE_PLACE_API');

  SearchRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<SearchData> getInfomation({
    required String name,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'fields' : 'formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry',
        'input' : '${name}',
        'inputtype' :'textquery',
        'key' : APIKEY
      }
    );


    if(response.statusCode == 200){
      if(SearchData.fromMap(response.data) == null){
        throw new Exception('Error');
      } else {
        return SearchData.fromMap(response.data);
      }
    }else{
      throw new Exception('response Error');
    }
  }
}