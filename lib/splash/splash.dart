import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:starshmucks/common_things.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../boxes.dart';
import '../model/user_model.dart';
import '../signin/signin.dart';
import '/home_screen.dart';

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

  check(List<UserData> data) async {
    int userKey;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userKey = prefs.getInt("userkey")!;
    for (int i = 0; i < data.length; i++) {
      if (data[i].email == data[userKey].email &&
          data[i].password == data[userKey].password) {
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
      body: ValueListenableBuilder<Box<UserData>>(
        valueListenable: Boxes.getUserData().listenable(),
        builder: (context, box, _) {
          final data = box.values.toList().cast<UserData>();
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
