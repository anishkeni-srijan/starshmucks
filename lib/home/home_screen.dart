import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
import '../common_things.dart';
import '../db/user_db.dart';
import '../model/menu_model.dart';
import '../providers/learnmore_provider.dart';
import 'now_serving.dart';
import 'offers_data.dart';
import '/db/menu_db.dart';
import '../rewards/rewards.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool cartinit = false;
late String username;

class _HomePageState extends State<HomePage> {
  late MenuDB db;
  List<MenuModel> data = [];
  List<Map<String, dynamic>> userddt = [];
  late var product;
  late var tier = '';
  late double rewards = 0;
  late UserDB udb;
  void initState() {
    udb = UserDB();
    udb.initDBUserData();
    getUser();
    db = MenuDB();
    db.initDBMenu();
    getdata();
    putdata();
    // setUserForLogin();
    super.initState();
  }

  getcurrenttier() {
    rewards = usernames[0]['rewards'];
    tier = usernames[0]['tier'];
  }

  getnexttier() {
    usernames.isEmpty
        ? nexttier = "bronze"
        : usernames[0]['rewards'] > 10
            ? nexttier = "gold"
            : nexttier = 'silver';
  }

  List<Map<String, dynamic>> usernames = [];
  getUser() async {
    usernames = await udb.getDataUserData();
    getcurrenttier();
    getnexttier();
    setState(() {});
  }

  getdata() async {
    data = await db.getDataMenu();
    setState(() {});
  }

  putdata() async {
    final String response =
        await DefaultAssetBundle.of(context).loadString("json/menu.json");
    final responseData = jsonDecode(response);
    for (var item = 0; item < responseData['Menu'].length; item++) {
      product = MenuModel.fromJson(responseData['Menu'][item]);
      db.insertDataMenu(product);
    }
  }

  setUserForLogin(email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('signedInEmail', email);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (usernames.isEmpty)
      return CircularProgressIndicator(backgroundColor: HexColor("#175244"));
    else {
      username = usernames[0]['name'];
      String email = usernames[0]['email'];
      setUserForLogin(email);
      initcart();
      return Scaffold(
          persistentFooterButtons: cartinit ? [viewincart()] : null,
          body: SingleChildScrollView(
            child: Column(
              children: [
                usernames.isEmpty
                    ? const CircularProgressIndicator()
                    : getbanner(context, username, tier, rewards),
                Container(
                  padding: const EdgeInsets.only(left: 10,top: 20,bottom: 10),
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    'Offers',
                    style: TextStyle(
                      color: HexColor("#175244"),
                      fontWeight: FontWeight.w700,
                    ),
                    minFontSize: 25,
                  ),
                ),
                const GetOffers(),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    'Now Serving',
                    style: TextStyle(
                      color: HexColor("#175244"),
                      fontWeight: FontWeight.w700,
                    ),
                    minFontSize: 25,
                  ),
                ),
                const NowServing(),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    'Learn More About Our Drinks',
                    style: TextStyle(
                      color: HexColor("#175244"),
                      fontWeight: FontWeight.w700,
                    ),
                    minFontSize: 25,
                  ),
                ),
                learnmore(context),
              ],
            ),
          ));
    }
  }
}

getbanner(context, username, tier, rewards) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.2,
    decoration: BoxDecoration(
      color: HexColor("#175244"),
      image: DecorationImage(
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.05),
          BlendMode.dstATop,
        ),
        image: const ExactAssetImage('images/shmucks.png'),
      ),
    ),
    child: Column(
      children: [
     Container(
          transform: Matrix4.translationValues(0, 28, 0),
          child: Text(
            '${'Hi ' + username}!',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
            BoxShadow(
            blurRadius: 10.0,
          ),
  ]),

          transform: Matrix4.translationValues(
            0,
            MediaQuery.of(context).size.height*0.1,
            0,
          ),
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
              children: [
                Icon(
                  Icons.stars_sharp,
                  color: tier == "bronze"
                      ? Colors.brown
                      : tier == "silver"
                          ? Colors.grey
                          : Colors.amberAccent,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        'Tier',
                        style: TextStyle(color: HexColor('#175244'), fontSize: 12),
                      ),
                      AutoSizeText(
                        tier == 'silver'
                            ? "Silver"
                            : tier == 'gold'
                                ? "Gold"
                                : "Bronze",
                        style: TextStyle(
                          color: tier == "bronze"
                              ? Colors.brown
                              : tier == "silver"
                                  ? Colors.grey
                                  : Colors.amberAccent,
                        ),
                        minFontSize: 12,
                      )
                    ],
                  ),
                ),

                Container(

                  child: const Icon(
                    Icons.card_giftcard,
                    color: Colors.amber,
                    size: 20,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Rewards',
                        style: TextStyle(color: HexColor('#175244'), fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2.0,
                        left: 8,
                      ),
                      child: AutoSizeText(
                        rewards.toStringAsFixed(2),
                        style: TextStyle(
                          color:HexColor('#175244'),
                        ),
                        minFontSize: 12,
                      ),
                    )
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  transform: Matrix4.translationValues(
                    20,
                    0,
                    0,
                  ),
                  child: tier == 'gold'
                      ?  AutoSizeText(
                          'You are a Gold tier customer.',
                          style: TextStyle(
                            color: HexColor('#175244'),
                          ),
                          minFontSize: 15,
                        )
                      : AutoSizeText(
                          'You are ${(20 - rewards).toStringAsFixed(2)} points away from $nexttier tier.',
                          style: TextStyle(
                            color: HexColor('#175244'),
                          ),
                          minFontSize: 15,
                        ),
                ),
                Container(
                  child: IconButton(
                    onPressed: () {
                      Get.to(const Rewards(),transition: Transition.rightToLeftWithFade);
                    },
                    icon: Icon(
                      Icons.play_arrow_sharp,
                      color:HexColor('#175244'),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            ),
        ),
      ],
    ),
  );
}

learnmore(context) {
  final learnmorep = Provider.of<Learnmore>(context);
  learnmorep.fetchData(context);
  return SizedBox(
    height: 250,
    child: ListView.builder(
      itemCount: learnmorep.learnmore.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HexColor('#ebd8a7'),
                  Colors.white,
                ],
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.42,
            width: MediaQuery.of(context).size.width * 0.86,
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    learnmorep.learnmore[index].image,
                    width: 250,
                  ),
                ),
                Container(
                  child: Container(
                    child: Text(
                      learnmorep.learnmore[index].title,
                      style: TextStyle(
                        color: HexColor('#175244'),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    learnmorep.learnmore[index].tag,
                    style: TextStyle(
                      color: HexColor('#175244'),
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
