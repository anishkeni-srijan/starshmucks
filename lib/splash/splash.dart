import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../boxes.dart';
import '../model/user_model.dart';
import '../signin/signin.dart';
import '/common_things.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool flag = false;
  void initState() {
    super.initState();
  }

  check(List<UserDataModel> data) async {
    for (int i = 0; i < data.length; i++) {
      if (data[i].email == data[0].email &&
          data[i].password == data[0].password) {
        flag = true;
        setState(() {});
      } else {
        flag = false;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#175244"),
      body: ValueListenableBuilder<Box<UserDataModel>>(
        valueListenable: Boxes.getUserData().listenable(),
        builder: (context, box, _) {
          final data = box.values.toList().cast<UserDataModel>();
          check(data);
          return Container(
            child: SplashScreenView(
              duration: Duration(milliseconds: 1500),
              imageSrc: "images/shmucks.png",
              navigateRoute: flag ? bottomBar() : SigninPage(),
            ),
          );
        },
      ),
    );
  }
}
