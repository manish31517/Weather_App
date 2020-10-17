import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/bloc/setting_bloc.dart';
import 'package:weatherapp/bloc/themerbloc.dart';
import 'package:weatherapp/model/weather.dart';
import 'package:weatherapp/states/settingState.dart';
import 'package:flutter/material.dart';
class TempratureWidget extends StatelessWidget{
  final Weather weather;
  TempratureWidget({Key key, @required this.weather}):
      assert(weather != null),
       super(key: key);
  // convert celcius to fahrenheit
   int _toFahrenheit(double celsius)
   {
     return ((celsius *9/5)+32).round();
   }
   String _formattedTemperature(double temp,TempratureUnit tempratureUnit) =>
       tempratureUnit  == TempratureUnit.fahrenheit ? '${_toFahrenheit(temp)}F' : '${temp.round()}C';
   BoxedIcon _mapWeatherConditionToIcon({WeatherCondition weatherCondition})
   {
     switch(weatherCondition){
       case WeatherCondition.clear:
       case WeatherCondition.lightCloud:
         return BoxedIcon(WeatherIcons.day_sunny);
         break;
       case WeatherCondition.hail:
       case WeatherCondition.snow:
       case WeatherCondition.sleet:
         return BoxedIcon(WeatherIcons.snow);
         break;
       case WeatherCondition.heavyCloud:
         return BoxedIcon(WeatherIcons.day_sunny);
         break;
       case WeatherCondition.heavyRain:
       case WeatherCondition.lightRain:
       case WeatherCondition.showers:
         return BoxedIcon(WeatherIcons.rain);
         break;
       case WeatherCondition.thunderstorm:
         return BoxedIcon(WeatherIcons.thunderstorm);
       case WeatherCondition.unknown:
         return BoxedIcon(WeatherIcons.sunset);
     }
     return BoxedIcon(WeatherIcons.sunset);
   }
   @override
  Widget build(BuildContext context) {

     return Column(
       children: <Widget>[
         Row(
           mainAxisAlignment:  MainAxisAlignment.center,
           children: <Widget>[
            // add an icon here
             _mapWeatherConditionToIcon(weatherCondition: weather.weatherConditions),
             Padding(
             padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
               child: BlocBuilder<SettingBloc, SettingState>(
                 builder: (context,settingState){
                   return Column(
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: <Widget>[
                       Text('Min temp : ${_formattedTemperature(
                           weather.minTemp,
                         settingState.tempratureUnit
                       )}',
                         style: TextStyle(
                           fontSize: 18,
                           color: BlocProvider.of<ThemeBloc>(context).state.textColor
                         ),
                       ),
                       Text('Temp : ${_formattedTemperature(
                           weather.temp,
                           settingState.tempratureUnit
                       )}',
                         style: TextStyle(
                             fontSize: 18,
                             color: BlocProvider.of<ThemeBloc>(context).state.textColor
                         ),
                       ),
                       Text('Max temp : ${_formattedTemperature(
                           weather.maxTemp,
                           settingState.tempratureUnit
                       )}',
                         style: TextStyle(
                             fontSize: 18,
                             color: BlocProvider.of<ThemeBloc>(context).state.textColor
                         ),
                       )

                     ],
                   );
                 },
               ),
             )
           ],
         )
       ],
     );
  }

}