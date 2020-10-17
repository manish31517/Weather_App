import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weatherapp/events/themevenet.dart';
enum TempratureUnit{
  fahrenheit,
  celsius
}
class SettingState extends Equatable{
  final TempratureUnit tempratureUnit;
  const SettingState({@required this.tempratureUnit});
  @override
  List<Object> get props => [];
}