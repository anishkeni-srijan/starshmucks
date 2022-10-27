import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:starshmucks/money.dart';
import 'package:starshmucks/order_page.dart';

import '/gift_card_page.dart';
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
                  Get.to(
                    HomePage(),
                    transition: Transition.rightToLeft,
                  );
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
                onPressed: () {
                  Get.to(
                    GiftCardPage(),
                    transition: Transition.rightToLeft,
                  );
                  homeroute = false;
                },
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
                onPressed: () {
                  Get.to(
                    MoneyPage(),
                    transition: Transition.rightToLeft,
                  );
                },
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
                    transition: Transition.rightToLeft,
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
    onPressed: () {
      Get.to(OrderPage(),transition: Transition.downToUp);
    },
    child: Icon(
      Icons.coffee_maker_outlined,
      color: Colors.white,
    ), //icon inside button
  );
}
