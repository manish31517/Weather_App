import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/events/themevenet.dart';
import 'package:weatherapp/model/weather.dart';
import 'package:weatherapp/states/themeState.dart';
class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{
  //initial state
  ThemeBloc():
      super(ThemeState(backgroundColor: Colors.lightBlue, textColor: Colors.white));
   @override
  Stream<ThemeState> mapEventToState(ThemeEvent themeEvent) async* {
     ThemeState newThemeState;
     if (themeEvent is ThemeEventWeatherChanged) {
       final weatherCondition = themeEvent.weatherCondition;
       if (weatherCondition == WeatherCondition.clear ||
           weatherCondition == WeatherCondition.lightCloud) {
         newThemeState =
             ThemeState(backgroundColor: Colors.yellow, textColor: Colors.blue);
       }
       else if (weatherCondition == WeatherCondition.hail
           || weatherCondition == WeatherCondition.snow ||
           weatherCondition == WeatherCondition.sleet) {
         newThemeState = ThemeState(
             backgroundColor: Colors.lightBlue, textColor: Colors.blue);
       }
     else if (weatherCondition == WeatherCondition.thunderstorm) {
         newThemeState= ThemeState(
           backgroundColor: Colors.deepPurple,
           textColor: Colors.white
         );
     }else{
       newThemeState =ThemeState(backgroundColor: Colors.lightBlue, textColor: Colors.white);
       }
     yield newThemeState;
   }
   }
} 