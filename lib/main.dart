import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:starshmucks/providers/learnmore_provider.dart';
import 'package:starshmucks/providers/nowserving_provider.dart';
import 'package:starshmucks/providers/offers_provider.dart';

import '/forgotpassword/forgot_password.dart';
import '/signup/bloc/signup_bloc.dart';
import '/signup/signup.dart';
import '/signin/bloc/signin_bloc.dart';
import '/signin/signin.dart';
import '/splash/bloc/splash_bloc.dart';
import '/splash/splash.dart';
import 'forgotpassword/bloc/forgotpassword_bloc.dart';
import 'model/user_model.dart';
import 'resetpassword/bloc/resetpassword_bloc.dart';
import 'resetpassword/reset_password.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter());
  await Hive.openBox<UserData>('signupdata');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashScreenBloc(),
          child: Splash(),
        ),
        BlocProvider(
          create: (context) => SigninBloc(),
          child: SigninPage(),
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
