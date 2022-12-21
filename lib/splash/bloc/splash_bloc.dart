import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/splash/bloc/splash_events.dart';
import '/splash/bloc/splash_states.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashInitialState()) {
    late bool flag = false;
    checkIfLoggedIn() async {
      final prefs = await SharedPreferences.getInstance();
      String? userEmail = prefs.getString('signedInEmail');
      if (userEmail != null) flag = true;
    }

    on<OnSplashEvent>(
      (event, emit) async {
        await Future<void>.delayed(const Duration(seconds: 1));
        emit(
          SplashloadingState(),
        );
      },
    );

    on<LoginStatusCheckEvent>(
      (event, emit) {
        checkIfLoggedIn();
        flag
            ? emit(
                UserExistsState(),
              )
            : emit(
                NewUserState(),
              );
      },
    );
  }
//else if the user exists
}
