
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starshmucks/splash/bloc/splash_bloc.dart';
import 'package:starshmucks/splash/splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login/bloc/signin_bloc.dart';
import 'login/signin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
          providers:[BlocProvider(
        create: (context)=> SplashScreenBloc(),
        child: Splash(),
      ),
            BlocProvider(
              create: (context)=> LoginBloc(),
              child: LoginPage(),
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




