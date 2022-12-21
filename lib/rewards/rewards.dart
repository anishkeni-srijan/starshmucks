import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '/rewards/rewarddetails.dart';
import '/common_things.dart';
import '/home/home_screen.dart';
import '../databse/user_db.dart';

class Rewards extends StatefulWidget {
  const Rewards({Key? key}) : super(key: key);

  @override
  State<Rewards> createState() => _RewardsState();
}

late double silvervalue = 0;
late double goldvalue = 0;
late double progvalue = 0;

String nexttier = '';

class _RewardsState extends State<Rewards> {
  String refLink = "http://starshmucks.com/refferal/cdJkk5";
  TextEditingController test = TextEditingController();
  late ItemScrollController itemScrollController = ItemScrollController();
  UserDB udb = UserDB();
  List<Map<String, dynamic>> usernames = [];

  getuser() async {
    usernames = await udb.getDataUserData();
    setState(() {});
    getnexttier();
    getprogress();
  }

  @override
  void initState() {
    getuser();
    super.initState();
  }

  getnexttier() {
    usernames.isEmpty
        ? nexttier = "silver"
        : usernames[0]['rewards'] > 10
            ? nexttier = "gold"
            : nexttier = 'silver';
    setState(() {});
  }

  getprogress() {
    if (usernames.isEmpty) {
      silvervalue = 0;
    } else {
      if (usernames[0]['rewards'] < 10) {
        silvervalue = usernames[0]['rewards'] / 10.0;
      } else if (usernames[0]['rewards'] > 10) {
        silvervalue = usernames[0]['rewards'] / 10.0;
        goldvalue = usernames[0]['rewards'] / 20.0;
      } else
        progvalue = 0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return usernames.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            persistentFooterButtons: cartinit ? [viewincart()] : null,
            appBar: gethomeappbar("Rewards", [Container()], true, 0.0),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 220,
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10,
                    ),
                    child: Card(
                      color: HexColor("#175244"),
                      margin: const EdgeInsets.only(top: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.black,
                      elevation: 4,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const AutoSizeText(
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
                                              usernames[0]['rewards']
                                                  .toStringAsFixed(2),
                                              style: const TextStyle(
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
                                                color: usernames[0]['tier'] ==
                                                        'gold'
                                                    ? Colors.amberAccent
                                                    : usernames[0]['tier'] ==
                                                            'silver'
                                                        ? Colors.grey
                                                        : Colors.brown,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    usernames[0]['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Image.asset(
                                "images/shmucks.png",
                                width: 150,
                                height: 150,
                              ),
                            )
                          ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => Rewarddetails());
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 1,
                      child: Card(
                        elevation: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: usernames[0]['tier'] == 'gold'
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text("Congratulations You're a"),
                                        Text(
                                          " Gold ",
                                          style: TextStyle(
                                            color: Colors.amberAccent,
                                          ),
                                        ),
                                        Text("Tier customer."),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                          "You are ${res.toStringAsFixed(2)} points away from ",
                                          style: TextStyle(
                                            color: HexColor("#175244"),
                                          ),
                                          minFontSize: 15,
                                        ),
                                        AutoSizeText(
                                          nexttier,
                                          style: TextStyle(
                                            color: nexttier == 'silver'
                                                ? Colors.grey
                                                : Colors.amberAccent,
                                          ),
                                          minFontSize: 18,
                                        ),
                                        AutoSizeText(
                                          " tier.",
                                          style: TextStyle(
                                            color: HexColor("#175244"),
                                          ),
                                          minFontSize: 18,
                                        ),
                                      ],
                                    ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildstar(Colors.brown, "0 points"),
                                  buildprogressbar(
                                      context, Colors.brown, silvervalue),
                                  buildstar(Colors.grey, "10 points"),
                                  buildprogressbar(
                                      context, Colors.grey, goldvalue),
                                  buildstar(Colors.amberAccent, "20 points"),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 8, right: 8, top: 10, bottom: 10),
                              child: Divider(
                                color: Colors.black38,
                                height: 1,
                                thickness: 0.8,
                                indent: 0,
                                endIndent: 0,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => Rewarddetails(),
                                      transition:
                                          Transition.rightToLeftWithFade);
                                },
                                child: Text(
                                  "Know More",
                                  style: TextStyle(color: HexColor("#175244")),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 10,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Refer a friend",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 23,
                                        color: HexColor("#175244")),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "And you both save \$XX.",
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      CupertinoIcons.info_circle,
                                      color: HexColor("#175244"),
                                    ),
                                    const SizedBox(
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
                                const SizedBox(
                                  height: 20,
                                ),
                                buildRow("1", "Invite your friends",
                                    "Just share your link"),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin:
                                        const EdgeInsets.only(left: 30, top: 5),
                                    child: const DottedLine(
                                      direction: Axis.vertical,
                                      lineLength: 35,
                                      lineThickness: 2,
                                      dashLength: 6,
                                      dashColor: Colors.grey,
                                    ),
                                  ),
                                ),
                                buildRow(
                                    "2", "They get coffee", "with \$XX off"),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin:
                                        const EdgeInsets.only(left: 30, top: 5),
                                    child: const DottedLine(
                                      direction: Axis.vertical,
                                      lineLength: 35,
                                      lineThickness: 2,
                                      dashLength: 6,
                                      dashColor: Colors.grey,
                                    ),
                                  ),
                                ),
                                buildRow("3", "You make savings",
                                    "and get \$XX off"),
                                const SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: HexColor("#175244")),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        refLink,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: HexColor("#175244"),
                                            fontSize: 15),
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          Clipboard.setData(
                                                  ClipboardData(text: refLink))
                                              .then(
                                            (value) {
                                              return ScaffoldMessenger.of(
                                                      context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor:
                                                      HexColor("#175244"),
                                                  content: const Text(
                                                    'Referral link copied',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  HexColor("#175244")),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Text(
                                            "COPY",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        )),
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

  Container buildprogressbar(BuildContext context, Color color, progress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width * 0.26,
      child: LinearProgressIndicator(
        // color: Colors.white,
        backgroundColor: HexColor("#175244"),
        valueColor: AlwaysStoppedAnimation<Color>(
            usernames[0]['tier'] == 'gold' ? Colors.amberAccent : color),
        value: progress,
      ),
    );
  }

  Column buildstar(Color color, text) {
    return Column(
      children: [
        Icon(
          Icons.stars_sharp,
          color: color,
        ),
        Text(text, style: TextStyle(fontSize: 11))
      ],
    );
  }

  Row buildRow(number, maintext, subtext) {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CircleAvatar(
            backgroundColor: HexColor("#175244"),
            radius: 30,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              maintext,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              subtext,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                  color: Colors.grey.shade600),
            ),
          ],
        )
      ],
    );
  }
}
