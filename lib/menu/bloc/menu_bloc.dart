import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menu_events.dart';
import 'menu_states.dart';


class MenuBloc extends Bloc<MenuEvents, MenuStates> {
  MenuBloc() : super(const MenuInitialState()) {
    late bool flag = false;
    checkIfLoggedIn() async {
      final prefs = await SharedPreferences.getInstance();
      String? userEmail = prefs.getString('signedInEmail');
      if (userEmail != null) flag = true;
    }

    on<OnAddToCartEvent>(
          (event, emit) async {
        await Future<void>.delayed(const Duration(seconds: 1));
        // emit(
        //   const,
        // );
      },
    );

    on<OnAddToWishlistEvent>(
          (event, emit) {
        checkIfLoggedIn();
        // flag
        //     ? emit(
        //   const
        // )
        //     : emit(
        //   const ,
        // );
      },
    );
  }
//else if the user exists
}
