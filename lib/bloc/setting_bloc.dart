import 'package:weatherapp/events/settingEvent.dart';
import 'package:weatherapp/states/settingState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SettingBloc extends Bloc<SettingEvent,SettingState> {
  //initial sTate
  SettingBloc():super(SettingState(tempratureUnit: TempratureUnit.celsius));
  @override
  Stream<SettingState> mapEventToState(SettingEvent settingEvent) async*{
    if(settingEvent is SettingEventToggleUnit){
      yield SettingState(
        tempratureUnit: state.tempratureUnit ==TempratureUnit.celsius ? TempratureUnit.fahrenheit:TempratureUnit.celsius,
      );
    }
  }
}