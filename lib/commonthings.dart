import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';

import '/home_screen.dart';
import '/user_profile.dart';

Widget getbottombar(BuildContext context) {
  bool homeroute;
  return Container(
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        topLeft: Radius.circular(30),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black38,
          spreadRadius: 0,
          blurRadius: 10,
        ),
      ],
    ),
    child: ClipRRect(
      child: BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: IconButton(
                iconSize: 25,
                icon: Icon(
                  Icons.home_outlined,
                  color: HexColor("#036635"),
                ),
                onPressed: () {
                  Get.to(HomePage());
                },
              ),
            ),
            Expanded(
              child: IconButton(
                iconSize: 25,
                icon: Icon(
                  Icons.card_giftcard,
                  color: HexColor("#036635"),
                ),
                onPressed: () {},
              ),
            ),
            Expanded(child: new Text('')),
            Expanded(
              child: IconButton(
                iconSize: 25,
                icon: Icon(
                  Icons.money,
                  color: HexColor("#036635"),
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: IconButton(
                iconSize: 25,
                icon: Icon(
                  Icons.person_outline_outlined,
                  color: HexColor("#036635"),
                ),
                onPressed: () {
                  Get.to(
                    UserProfile(),
                  );
                  homeroute = false;
                },
              ),
            ),
          ],
        ),
      ),
      // BottomNavigationBar(
      //   currentIndex: 1,
      //   //iconSize: 24,
      //   // selectedIconTheme: IconThemeData(size: 50),
      //   backgroundColor: Colors.white,
      //   items: [
      //     BottomNavigationBarItem(
      //       label: 'Home',
      //       backgroundColor: Colors.lightGreen,
      //       icon: IconButton(
      // onPressed: () {
      //   homeroute = true;
      //   homeroute
      //       ? null
      //       : Get.to(
      //           HomePage(),
      //         );
      // },
      //         icon: Icon(
      //           Icons.home_outlined,
      //           color: HexColor("#036635"),
      //         ),
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'Profile',
      //       icon: IconButton(
      //         onPressed: () {
      //           Get.to(
      //             UserProfile(),
      //           );
      //           homeroute = false;
      //         },
      //         icon: Icon(
      //           Icons.person_outline_outlined,
      //           color: HexColor("#036635"),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    ),
  );
}

orderbutton() {
  return FloatingActionButton(
    //Floating action button on Scaffold
    elevation: 10,
    backgroundColor: Color(0xffb036635),
    onPressed: () {},
    child: Icon(
      Icons.coffee_maker_outlined,
      color: Colors.white,
    ), //icon inside button
  );
}
