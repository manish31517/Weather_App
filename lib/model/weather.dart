/*
 "consolidated_weather":
[{"id":4884843876843520,
"weather_state_name":"Heavy Cloud",
"weather_state_abbr":"hc","wind_direction_compass":"WSW",
"created":"2020-10-16T12:24:21.089289Z",
"applicable_date":"2020-10-16",
"min_temp":2.4699999999999998,
"max_temp":12.175,
"the_temp":11.585,
"wind_speed":9.323475043039316,
"wind_direction":245.50114364339595,
"air_pressure":1021.0,
"humidity":42,
"visibility":13.558008729022509,
"predictability":71}]
 */
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
enum WeatherCondition{
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}
class Weather extends Equatable{
 final WeatherCondition weatherConditions;
 final String formattedCondition;
 final double minTemp;
 final double temp;
 final double maxTemp;
 final int locationId;
 final String created;
 final DateTime lastUpdated;
 final String location;
 const Weather({
   this.weatherConditions,
   this.formattedCondition,
   this.minTemp,
   this.temp,
   this.maxTemp,
   this.locationId,
   this.created,
   this.lastUpdated,
   this.location
});
 @override
  List<Object> get props=> [
    weatherConditions,
   formattedCondition,
   minTemp,
   temp,
   maxTemp,
   locationId,
   created,
   lastUpdated,
   location
 ];
 // convert from Json to weather object

factory Weather.fromJSon(dynamic jsonObject)
{
  final consolidatedWeather = jsonObject['consolidated_weather'][0];
  return Weather(
    weatherConditions: _mapStringToWeathercondition(consolidatedWeather['weather_state_abbr'])?? '',
    formattedCondition: consolidatedWeather[''],
    minTemp: consolidatedWeather['min_temp'] as double,
    temp: consolidatedWeather['the_temp'] as double,
    maxTemp: consolidatedWeather['max_temp'] as double,
    locationId: jsonObject['world'] as int,
    created: consolidatedWeather['created'],
    lastUpdated: DateTime.now(),
    location: jsonObject['title']

  );
}
static WeatherCondition _mapStringToWeathercondition(String inputString){
  Map<String,WeatherCondition> map ={
    'sn': WeatherCondition.snow,
    'sl' : WeatherCondition.sleet,
    'h' : WeatherCondition.hail,
    't' : WeatherCondition.thunderstorm,
    'hr' : WeatherCondition.heavyRain,
    'lr' : WeatherCondition.lightRain,
    's' : WeatherCondition.showers,
    'hc' : WeatherCondition.heavyCloud,
    'lc': WeatherCondition.lightCloud,
     'c': WeatherCondition.clear
  };
  return map[inputString] ?? WeatherCondition.unknown;
}
}
