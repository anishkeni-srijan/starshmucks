import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';

import '/signin/signin.dart';
import 'boxes.dart';
import 'common_things.dart';
import 'db/user_db.dart';
import 'editdetails/edit_details.dart';
import 'home/home_screen.dart';
import 'model/user_model.dart';
import 'order/order_history.dart';
import '/help_page.dart';
import '/rewards.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<Map<String, dynamic>> usernames = [];
  getUser() async {
    usernames = await udb.getDataUserData();
    setState(() {});
  }

  late UserDB udb;
  void initState() {
    udb = UserDB();
    udb.initDBUserData();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (usernames.isEmpty)
      return CircularProgressIndicator();
    else {
      return Scaffold(
        // persistentFooterButtons: cartinit ? [viewincart()] : null,
        // backgroundColor: HexColor("#175244"),
        body: ValueListenableBuilder<Box<UserDataModel>>(
          valueListenable: Boxes.getUserData().listenable(),
          builder: (context, box, _) {
            final data = box.values.toList().cast<UserDataModel>();
            // print("pass  " + data[0].password);
            // print("email  " + data[0].email);
            // print(data[0].profileimage.toString());
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 250.0,
                    color: HexColor("#175244"),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: data[0].profileimage == null
                                ? DecorationImage(
                                    image: AssetImage(
                                        'images/profile1.jpg')) // set a placeholder image when no photo is set
                                : DecorationImage(
                                    image: FileImage(
                                        File(data[0].profileimage!.path)),
                                    fit: BoxFit.cover,
                                  ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(75.0),
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 4.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            usernames[0]['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        profileTile(
                          text: 'My Account',
                          press: () {
                            Get.to(
                              EditProfile(),
                            );
                          },
                          icon: Icons.account_circle_outlined,
                        ),
                        const DividerForTiles(),
                        profileTile(
                          text: 'Orders',
                          press: () {
                            Get.to(Orders());
                          },
                          icon: Icons.coffee_outlined,
                        ),
                        const DividerForTiles(),
                        profileTile(
                          text: 'Rewards',
                          press: () {
                            Get.to(Rewards());
                          },
                          icon: Icons.star_outline_sharp,
                        ),
                        const DividerForTiles(),
                        profileTile(
                          text: 'Payment Mode',
                          press: () {},
                          icon: Icons.attach_money_sharp,
                        ),
                        const DividerForTiles(),
                        profileTile(
                          text: 'Help',
                          press: () {
                            Get.to(Help());
                          },
                          icon: Icons.help_outline_rounded,
                        ),
                        const DividerForTiles(),
                        profileTile(
                          text: 'Logout',
                          press: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('0');
                            Get.to(
                              SigninPage(),
                            );
                          },
                          icon: Icons.logout,
                        ),
                        DividerForTiles(),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    }
  }
}

class DividerForTiles extends StatelessWidget {
  const DividerForTiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: HexColor("#036635"),
      height: 1,
      thickness: 0.5,
      indent: 0,
      endIndent: 0,
    );
  }
}

class profileTile extends StatelessWidget {
  const profileTile({
    Key? key,
    required this.text,
    required this.press,
    required this.icon,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
              icon,
              size: 30,
              color: HexColor("#036635"),
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
            Icon(
              Icons.arrow_forward_ios,
              color: HexColor("#036635"),
            ),
          ],
        ),
      ),
    );
  }
}
