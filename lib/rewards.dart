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
        body: SingleChildScrollView(
            child: Column(

          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    '${'Hi ' + username}',
                    style: TextStyle(
                      color: HexColor("#175244"),
                      fontSize: 25,
                    ),
                  ),
                  Icon(
                    Icons.stars_sharp,
                    color: Colors.amberAccent,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 20),
              alignment: Alignment.topLeft,
              child: Text(
                'Welcome back!',
                style: TextStyle(
                  color: HexColor("#175244"),
                  fontSize: 35,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 40,
                bottom: 20,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Image.asset(
                        'images/stars.png',
                        width: 30,
                      ),
                    ),
                    Column(
                      children: [
                        AutoSizeText(
                          '1/5',
                          style: TextStyle(
                            color: HexColor("#175244"),
                          ),
                          minFontSize: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5.0,
                          ),
                          child: AutoSizeText(
                            'Stars',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: HexColor("#175244"),
                            ),
                            minFontSize: 18,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Icon(
                        Icons.card_giftcard,
                        color: Colors.amber,
                        size: 23,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          child: AutoSizeText(
                            '1',
                            style: TextStyle(
                              color: HexColor("#175244"),
                            ),
                            minFontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5.0,
                          ),
                          child: AutoSizeText(
                            'Rewards',
                            style: TextStyle(
                              color: HexColor("#175244"),
                              fontWeight: FontWeight.w600,
                            ),
                            minFontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
            SizedBox(height: 20,),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'images/leaf.png',
                  width: 250,
                ),
                Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Image.asset('images/trophy.png', width: 360)),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.all(10),
              child: AutoSizeText(
                'You are 4 stars away from another reward',
                style: TextStyle(
                  color: HexColor("#175244"),
                ),
                minFontSize: 18,
              ),
            ),
            SizedBox(height: 20,),
            ExpansionTile(
              childrenPadding: const EdgeInsets.all(20.0),
              iconColor: HexColor("#175244"),
              collapsedIconColor:HexColor("#175244") ,
              title: Text('Know more', style: TextStyle(color: HexColor("#175244")),),
              children: [
                Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.')
              ],
            )
          ],
        )));
  }
}
