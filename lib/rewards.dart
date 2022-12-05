import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:math';

import 'db/user_db.dart';
import '/common_things.dart';
import '/home/home_screen.dart';

class Rewards extends StatefulWidget {
  const Rewards({Key? key}) : super(key: key);

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  String refLink = "http://starshmucks.com/refferal/cdJkk5";
  TextEditingController test = TextEditingController();

  List<Map<String, dynamic>> usernames = [];
  getuser() async {
    UserDB udb = UserDB();
    usernames = await udb.getDataUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getuser();
    double res =10.0 - usernames[0]['rewards'];
    double progvalue = usernames[0]['rewards']/10.0;
    return Scaffold(
      persistentFooterButtons: cartinit ? [viewincart()] :null,
      appBar: AppBar(
        title: Text('Rewards'),
        backgroundColor: Colors.white,
        foregroundColor: HexColor("#175244"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Card(
                color: HexColor("#175244"),
                margin: EdgeInsets.only(top: 20),
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
                                    usernames[0]['rewards'].toStringAsFixed(2),
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
                              usernames[0]['name'],
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
            SizedBox(
              height: 20,
            ),
            Center(
              child: AutoSizeText(
                "You are " + res.toStringAsFixed(2) + " stars away from another reward",
                style: TextStyle(
                  color: HexColor("#175244"),
                ),
                minFontSize: 18,
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width*1,
              child: Card(
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: LinearProgressIndicator(
                        // color: Colors.white,
                        // backgroundColor: Colors.cyanAccent,
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                        value: progvalue,
                        
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width*1,
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Refer a friend",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 25,
                                color: HexColor("#175244")),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "And you both save \$XX.",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                CupertinoIcons.info_circle,
                                color: HexColor("#175244"),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "How it works",
                                style: TextStyle(
                                    color: HexColor("#175244"),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: CircleAvatar(
                                  backgroundColor: HexColor("#175244"),
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  radius: 30,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Invite your friends",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Just share your link",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.grey.shade600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 30, top: 5),
                              child: DottedLine(
                                direction: Axis.vertical,
                                lineLength: 35,
                                lineThickness: 2,
                                dashLength: 6,
                                dashColor: Colors.grey,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: CircleAvatar(
                                  backgroundColor: HexColor("#175244"),
                                  child: Text(
                                    "2",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  radius: 30,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "They get coffee",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "With \$XX off",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.grey.shade600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 30, top: 5),
                              child: DottedLine(
                                direction: Axis.vertical,
                                lineLength: 35,
                                lineThickness: 2,
                                dashLength: 6,
                                dashColor: Colors.grey,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: CircleAvatar(
                                  backgroundColor: HexColor("#175244"),
                                  child: Text(
                                    "3",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  radius: 30,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "You make savings!",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Then you get \$XX off",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.grey.shade600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            children: [
                          Container(
                            margin:EdgeInsets.only(top:5),
                            width:MediaQuery.of(context).size.width*0.6,
                          padding:EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1.0, color: HexColor("#175244")),
                              ),
                              color: Colors.white,
                            ),
                          child:Text(
                                refLink,
                                overflow:TextOverflow.ellipsis,
                                style: TextStyle(color: HexColor("#175244"), fontSize: 15),
                              ),),
                              ElevatedButton(
                                onPressed: () async {
                                  Clipboard.setData(ClipboardData(text: refLink))
                                      .then(
                                    (value) {
                                      return ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: HexColor("#175244"),
                                          content: Text('Referral link copied',style: TextStyle(color: Colors.white),),
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(HexColor("#175244")),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  child: Text("COPY",
                                    style: TextStyle(color: Colors.white, fontSize: 15),),
                                )
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
