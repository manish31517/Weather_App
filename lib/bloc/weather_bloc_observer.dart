import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBlocObserver extends BlocObserver{
  @override
  void onEvent(Bloc bloc ,Object event){
    super.onEvent(bloc, event);
    print('onEvent $event');
  }
  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
    print('ontransition $transition');
  }
  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(cubit, error, stackTrace);
   print("onError $error");
  }
}