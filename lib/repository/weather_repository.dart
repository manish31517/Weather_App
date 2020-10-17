// Now weather Api
// https://www.metaweather.com
// SEarch by city
//https://www.metaweather.com//api/location/search/?query=india
// by location's id
// https://www.metaweather.com/api/location/2379574
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/model/weather.dart';
const baseUrl = 'https://www.metaweather.com';
final locationUrl= (city) => '${baseUrl}/api/location/search/?query=${city}';
final weatherUrl = (locationId) => '${baseUrl}/api/location/${locationId}';
class WeatherRepository {
  final http.Client httpClient;
  WeatherRepository({this.httpClient}):
      assert(httpClient != null);
  Future<int> getLocationIdFromCity(String city) async{
    final response = await this.httpClient.get(locationUrl(city));
    if(response.statusCode==200)
      {
        final cities = jsonDecode(response.body) as List;
        return (cities.first)['world'] ?? Map();
      }
    else
      {
        throw Exception('Error getting location id of ${city} ');
      }
  }

  Future<Weather> fetchWeather(int locationId) async{
    final response = await this.httpClient.get(weatherUrl(locationId));
    if(response.statusCode != 200)
      {
        throw Exception('Error getting weather from locationId : ${locationId}');
      }
    final weatherJson = jsonDecode(response.body);
    return Weather.fromJSon(weatherJson);
  }

  Future<Weather> getWeatherFromCity(String city) async{
    final int locationId = await getLocationIdFromCity(city);
    return fetchWeather(locationId);
  }

}