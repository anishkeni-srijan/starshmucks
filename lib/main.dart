import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:starshmucks/editdetails/bloc/editdetails_bloc.dart';
import 'package:starshmucks/model/cart_model.dart';

import '/forgotpassword/forgot_password.dart';
import '/signup/bloc/signup_bloc.dart';
import '/signup/signup.dart';
import '/signin/bloc/signin_bloc.dart';
import '/signin/signin.dart';
import '/splash/splash.dart';
import 'editdetails/edit_details.dart';
import 'forgotpassword/bloc/forgotpassword_bloc.dart';
import 'model/user_model.dart';
import 'resetpassword/bloc/resetpassword_bloc.dart';
import 'resetpassword/reset_password.dart';
import '/providers/learnmore_provider.dart';
import '/providers/nowserving_provider.dart';
import '/providers/offers_provider.dart';
import '/providers/menu_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter());
  Hive.registerAdapter(CartDataAdapter());
  await Hive.openBox<UserData>('signupdata');
  await Hive.openBox<CartData>('cartdat');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => SigninBloc(),
          child: SigninPage(),
        ),
        BlocProvider(
          create: (context) => EditdetailsBloc(),
          child: EditProfile(),
        ),
        BlocProvider(
          create: (context) => SignupBloc(),
          child: SignupPage(),
        ),
        BlocProvider(
          create: (context) => ForgotpasswordBloc(),
          child: ForgotPasswordPage(),
        ),
        BlocProvider(
          create: (context) => ResetpasswordBloc(),
          child: ResetPasswordPage(),
        ),
        ChangeNotifierProvider(create: (context) => OffersData()),
        ChangeNotifierProvider(create: (context) => NowServing()),
        ChangeNotifierProvider(create: (context) => Learnmore()),
        ChangeNotifierProvider(create: (context) => Menudata()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: GoogleFonts.ubuntuTextTheme(),
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: Splash(),
        ),
      ),
    );
  }
}
