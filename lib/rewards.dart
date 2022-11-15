import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:starshmucks/home_screen.dart';

import 'boxes.dart';
import 'model/user_model.dart';

class Rewards extends StatefulWidget {
  const Rewards({Key? key}) : super(key: key);

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  @override
  Widget build(BuildContext context) {
    final box = Boxes.getUserData();
    final data = box.values.toList().cast<UserData>();
    return Scaffold(
      appBar: AppBar(
      title: Text('Rewards'),
      backgroundColor: Colors.white,
      foregroundColor: HexColor("#175244"),
    ),
      body: SingleChildScrollView(child: Column(
        children: [
          getbanner(context, username),
        ],
      )),
    );
  }
}
