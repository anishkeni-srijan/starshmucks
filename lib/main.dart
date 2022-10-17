
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:starshmucks/splash/splash.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
        title: 'MyShop',
        theme: ThemeData(primarySwatch: Colors.grey),
        home: Splash(),
        debugShowCheckedModeBanner: false,

    );
  }

}



