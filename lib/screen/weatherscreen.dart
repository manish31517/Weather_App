import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/bloc/themerbloc.dart';
import 'package:weatherapp/bloc/weatherbloc.dart';
import 'package:weatherapp/events/themevenet.dart';
import 'package:weatherapp/events/weather_event.dart';
import 'package:weatherapp/screen/city_search_screen.dart';
import 'package:weatherapp/screen/settingScreen.dart';
import 'package:weatherapp/screen/temprature_widget.dart';
import 'package:weatherapp/states/themeState.dart';
import 'package:weatherapp/states/weather_state.dart';
class WeatherScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_WeatherScreenState();
}
class _WeatherScreenState extends State<WeatherScreen>{
  Completer<void> _completer;
  @override
  void initState(){
    super.initState();
    _completer =Completer();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App using flutter Bloc'),
        actions: <Widget>[
          IconButton(icon:Icon(Icons.settings) ,
              onPressed:(){
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => SettingScreen()));
            //navigate to SettingScreen
          }),
          IconButton(icon: Icon(Icons.search), onPressed: () async{
            //navigate to citySearhcScreen
            final typedCity= await Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => CitySearchScreen()));
           if(typedCity != null){
             BlocProvider.of<WeatherBloc>(context).add(
               WeatherEventRequested(city: typedCity)
             );
           }
          })
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc,WeatherState> (
          listener: (context,weatherState){
                if(weatherState is WeatherStateSuccess){
                  BlocProvider.of<ThemeBloc>(context).add(
                    ThemeEventWeatherChanged(weatherCondition: weatherState.weather.weatherConditions)
                  );
                  _completer ?.complete();
                  _completer = Completer();

                }
          },
          builder: (context,weatherState){
            if(weatherState is WeatherStateLoading)
              {
                return Center(child: CircularProgressIndicator());
              }
            if(weatherState is WeatherStateSuccess)
              {
                final weather = weatherState.weather;
                return BlocBuilder<ThemeBloc,ThemeState>(
                  builder:(context,themeState){
              return RefreshIndicator(
              onRefresh: (){
              BlocProvider.of<WeatherBloc>(context).add(
                  WeatherEventRefresh(city:weather.location)
              );
              // return a "Completer object"
                _completer.future;
              },
                child: Container(
                  color:themeState.backgroundColor,
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            weather.location,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color:themeState.textColor
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                          Center(
                            child: Text(
                              'Updated : ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: themeState.textColor
                              ),
                            ),
                          ),
                      // show more here , put together inside a widget
                      TempratureWidget(weather: weather )
                        ],
                      )
                    ],
                  ),
                ),
              );
              }
                    );
            }
            if(weatherState is WeatherStateFailure)
              {
                return Text('Something Went Wrong',
                style: TextStyle(color:Colors.redAccent,
                fontSize: 16
                ),
                );
              }
           return Center(
             child: Text(
               'Select a location first',
               style: TextStyle(fontSize: 30),
             ),
           );
          }

          )
      ),
    );
  }
}