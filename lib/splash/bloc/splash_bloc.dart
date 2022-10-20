import 'package:flutter_bloc/flutter_bloc.dart';

import '/splash/bloc/splash_events.dart';
import '/splash/bloc/splash_states.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(
            //if new user
            SplashInitialState()) {
    on<OnSplashEvent>(
      (event, emit) async {
        await Future<void>.delayed(const Duration(seconds: 1));
        emit(
          SplashloadingState(),
        );
      },
    );
  }
  //else if the user exists
}
