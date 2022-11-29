import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:starshmucks/home/home_screen.dart';
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

    return Scaffold(
        appBar: AppBar(
          title: Text('Rewards'),
          backgroundColor: Colors.white,
          foregroundColor: HexColor("#175244"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    'Welcome back!',
                    style: TextStyle(
                      color: HexColor("#175244"),
                      fontSize: 35,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Card(
                    color: HexColor("#175244"),
                    margin: EdgeInsets.only(top: 90),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Colors.black,
                    elevation: 4,
                    child: Container(
                      margin: EdgeInsets.only(left: 30),
                      transform: Matrix4.translationValues(-10, 20, 0),
                      height: 200,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  'My Points',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  minFontSize: 23,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5.0,
                                  ),
                                  child: Row(
                                    children: [
                                      AutoSizeText(
                                        'hi',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        minFontSize: 23,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2.0, left: 5),
                                        child: Icon(
                                          Icons.stars_sharp,
                                          color: Colors.amberAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                                Text(
                                  '${username}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              transform: Matrix4.translationValues(20, -20, 0),
                              child: Image.asset("images/shmucks.png"),
                            )
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
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
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reward History'),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('order1'), Text('20.0')],
                      );
                    },
                  )
                ],
              ),
            )
          ],
        )));
  }
}
