import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/bloc/setting_bloc.dart';
import 'package:weatherapp/events/settingEvent.dart';
import 'package:weatherapp/states/settingState.dart';
class SettingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Settings'),),
      body: ListView(
      children: <Widget>[
        BlocBuilder<SettingBloc, SettingState>(
          builder: (context,settingState){
           return ListTile(
             title: Text('Temprature Unit'),
             isThreeLine: true,
             subtitle: Text(
               settingState.tempratureUnit == TempratureUnit.celsius ? 'Celsius' : 'Fahrenheit'
             ),
             trailing : Switch(
               value: settingState .tempratureUnit== TempratureUnit.celsius,
               onChanged: (_) =>BlocProvider.of<SettingBloc>(context).add(SettingEventToggleUnit()),
               
             )
           );
          },
        )
      ],
      ),
    );
  }
}