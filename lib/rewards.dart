import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'db/user_db.dart';
import '/common_things.dart';
import '/home/home_screen.dart';
import 'model/user_model.dart';

class Rewards extends StatefulWidget {
  const Rewards({Key? key}) : super(key: key);

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  String refLink = "http://starshmucks.com/refferal/cdJkk5";
  TextEditingController test = TextEditingController();
  late ItemScrollController itemScrollController = ItemScrollController();
  UserDB udb = UserDB();
  List<Map<String, dynamic>> usernames = [];
  getuser() async {
    usernames = await udb.getDataUserData();
    setState(() {});
  }

  @override
  void initState() {
    getuser();
    super.initState();
  }

  late double silvervalue = 0;
  late double goldvalue = 0;
  late double progvalue = 0;
  @override
  Widget build(BuildContext context) {
    double res = 10.0 - usernames[0]['rewards'];
    if (usernames[0]['rewards'] < 10) {
      silvervalue = usernames[0]['rewards'] / 10.0;
    } else if (usernames[0]['rewards'] > 10) {
      silvervalue = usernames[0]['rewards'] / 10.0;
      goldvalue = usernames[0]['rewards'] / 100.0;
    } else
      progvalue = 0;
    return usernames.isEmpty
        ? const CircularProgressIndicator()
        : Scaffold(
            persistentFooterButtons: cartinit ? [viewincart()] : null,
            appBar: AppBar(
              title: const Text('Rewards'),
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
                      margin: const EdgeInsets.only(top: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.black,
                      elevation: 4,
                      child: Container(
                        margin: const EdgeInsets.only(left: 30),
                        transform: Matrix4.translationValues(-10, 20, 0),
                        height: 200,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            color:
                                                usernames[0]['tier'] == 'gold'
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
                                  const SizedBox(
                                    height: 70,
                                  ),
                                  Text(
                                    usernames[0]['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                transform:
                                    Matrix4.translationValues(20, -20, 0),
                                child: Image.asset("images/shmucks.png"),
                              )
                            ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: AutoSizeText(
                      "You are " +
                          res.toStringAsFixed(2) +
                          " stars away from " +
                          usernames[0]['tier'].toString() +
                          " tier.",
                      style: TextStyle(
                        color: HexColor("#175244"),
                      ),
                      minFontSize: 18,
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 1,
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.stars_sharp,
                                  color: Colors.brown,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  child: LinearProgressIndicator(
                                    // color: Colors.white,
                                    backgroundColor:HexColor("#175244"),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.brown),
                                    value: silvervalue,
                                  ),
                                ),
                                const Icon(Icons.stars_sharp,
                                    color: Colors.grey),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  child: LinearProgressIndicator(
                                    // color: Colors.white,
                                    backgroundColor:HexColor("#175244"),
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.grey),
                                    value: goldvalue,
                                  ),
                                ),
                                const Icon(Icons.stars_sharp,
                                    color: Colors.amberAccent),
                              ],
                            ),
                          ),
                        ],
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
                                        fontSize: 25,
                                        color: HexColor("#175244")),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "And you both save \$XX.",
                                  style: TextStyle(fontSize: 18),
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
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: CircleAvatar(
                                        backgroundColor: HexColor("#175244"),
                                        child: const Text(
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
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          "Invite your friends",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
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
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: CircleAvatar(
                                        backgroundColor: HexColor("#175244"),
                                        child: const Text(
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
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "They get coffee",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
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
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: CircleAvatar(
                                        backgroundColor: HexColor("#175244"),
                                        child: const Text(
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
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "You make savings!",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
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
}

class TierTile extends StatelessWidget {
  const TierTile({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
  }) : super(key: key);
  final String text;
  final Color color;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
          child: TextButton(
            onPressed: press,
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(20),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.stars_sharp,
                  size: 30,
                  color: color,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: HexColor("#036635"),
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
