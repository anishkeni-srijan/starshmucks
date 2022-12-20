import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/splash/bloc/splash_events.dart';
import '/splash/bloc/splash_states.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(
            //if new user
            SplashInitialState()) {
    late bool flag = false;
    checkifloggedin() async {
      final prefs = await SharedPreferences.getInstance();
      String? useremail = prefs.getString('signedInEmail');
      if (useremail != null) flag = true;
    }
    on<OnSplashEvent>(
      (event, emit) async {
        await Future<void>.delayed(const Duration(seconds: 1));
        emit(
          SplashloadingState(),
        );
      },
    );
    on<LoginStatuscheckEvent>(
      (event, emit) {
        checkifloggedin();
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
