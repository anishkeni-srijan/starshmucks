import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/signin/signin.dart';
import 'boxes.dart';
import 'commonthings.dart';
import 'editdetails/edit_details.dart';
import 'model/user_model.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}
late var userkey;
class _UserProfileState extends State<UserProfile> {
  getemail() async {

    final keypref = await SharedPreferences.getInstance();
    userkey = keypref.getInt('userkey')!;

    setState(() {});
    print(userkey);
  }

  @override

  void initState() {
    // TODO: implement initState
    getemail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#175244"),
      body: ValueListenableBuilder<Box<UserData>>(
        valueListenable: Boxes.getUserData().listenable(),
        builder: (context, box, _) {
          final data = box.values.toList().cast<UserData>();
          print("pass  " + data[userkey].password);
          print("email  " + data[userkey].email);

          return SingleChildScrollView(
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
                    image: DecorationImage(
                      image: AssetImage('images/profile1.jpg'),
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
                    data[userkey].name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                        press: () {},
                        icon: Icons.coffee_outlined,
                      ),
                      const DividerForTiles(),
                      profileTile(
                        text: 'Rewards',
                        press: () {},
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
                        press: () {},
                        icon: Icons.help_outline_rounded,
                      ),
                      const DividerForTiles(),
                      profileTile(
                        text: 'Logout',
                        press: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove('userkey');
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
