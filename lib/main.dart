import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/signup/bloc/signup_bloc.dart';
import '/signup/signup.dart';
import '/signin/bloc/signin_bloc.dart';
import '/signin/signin.dart';
import '/splash/bloc/splash_bloc.dart';
import '/splash/splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
        )
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.ubuntuTextTheme(),
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}
