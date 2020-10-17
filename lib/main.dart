import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/bloc/setting_bloc.dart';
import 'package:weatherapp/bloc/themerbloc.dart';
import 'package:weatherapp/bloc/weather_bloc_observer.dart';
import 'package:weatherapp/repository/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/screen/weatherscreen.dart';

import 'bloc/weatherbloc.dart';
void main() {
  Bloc.observer = WeatherBlocObserver();
  final WeatherRepository weatherRepository = WeatherRepository(httpClient: http.Client());
   runApp(MultiBlocProvider(
     providers: [
       BlocProvider<ThemeBloc> (create:(context)=> ThemeBloc()),
       BlocProvider<SettingBloc>(create: (context) => SettingBloc())
     ],
     child: MyApp(weatherRepository: weatherRepository,),
   )//MultiBlocProvider
   );

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final WeatherRepository weatherRepository;
  MyApp({Key key, @required this.weatherRepository}):
      assert(weatherRepository != null), super(key:key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: BlocProvider(
        create: (context) => WeatherBloc(
          weatherRepository:weatherRepository
        ),
        child: WeatherScreen(),
      ),
    );
  }
}
// Now weather Api
// https://www.metaweather.com
// SEarch by city
//https://www.metaweather.com//api/location/search/?query=india
// by location's id
// https://www.metaweather.com/api/location/2379574