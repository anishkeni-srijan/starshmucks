import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:starshmucks/home_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
      Container(
      height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: HexColor("#175244"),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.05),
                BlendMode.dstATop,
              ),
              image: ExactAssetImage('images/shmucks.png'),
            ),
          ),
          child: Column(
            children: [
              Container(
                transform: Matrix4.translationValues(0, 28, 0),
                child: Text(
                  '${'Hi ' + username}!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
      Container(
      padding: EdgeInsets.only(
      bottom: 20,
        left: 20,
      ),
          transform: Matrix4.translationValues(
            0,
            80,
            0,
          ),
          child: Row(
            children: [
              Container(
                transform: Matrix4.translationValues(
                  3,
                  -8,
                  0,
                ),
                child: Image.asset(
                  'images/stars.png',
                  width: 20,
                ),
              ),
              Column(
                children: [
                  AutoSizeText(
                    '1/5',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    minFontSize: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 2.0,
                      left: 8,
                    ),
                    child: AutoSizeText(
                      'Stars',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      minFontSize: 12,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                transform: Matrix4.translationValues(
                  0,
                  -8,
                  0,
                ),
                child: Icon(
                  Icons.card_giftcard,
                  color: Colors.amber,
                  size: 13,
                ),
              ),
              Column(
                children: [
                  Container(
                    transform: Matrix4.translationValues(
                      -18,
                      0,
                      0,
                    ),
                    child: AutoSizeText(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      minFontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 2.0,
                      left: 8,
                    ),
                    child: AutoSizeText(
                      'Rewards',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      minFontSize: 12,
                    ),
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                transform: Matrix4.translationValues(
                  30,
                  4,
                  0,
                ),
                child: AutoSizeText(
                  'You are 4 stars away from another reward',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  minFontSize: 15,
                ),
              ),]),)
        ],
      )),])
    ));
  }
}
