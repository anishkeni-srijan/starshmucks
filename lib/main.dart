import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/editdetails/bloc/editdetails_bloc.dart';
import '/forgotpassword/forgot_password.dart';
import '/providers/learnmore_provider.dart';
import '/signin/bloc/signin_bloc.dart';
import '/signin/signin.dart';
import '/signup/bloc/signup_bloc.dart';
import '/signup/signup.dart';
import '/splash/splash.dart';
import 'editdetails/edit_details.dart';
import 'forgotpassword/bloc/forgotpassword_bloc.dart';
import 'resetpassword/bloc/resetpassword_bloc.dart';
import 'resetpassword/reset_password.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        ChangeNotifierProvider(create: (context) => Learnmore()),
        //  ChangeNotifierProvider(create: (context) => Menudata()),
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
            primarySwatch: Colors.teal,
          ),
          debugShowCheckedModeBanner: false,
          home: Splash(),
        ),
      ),
    );
  }
}
