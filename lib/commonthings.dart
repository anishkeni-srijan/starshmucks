import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:starshmucks/providers/menu_provider.dart';
import 'package:starshmucks/providers/offers_provider.dart';
import '/home_screen.dart';
import '/user_profile.dart';
import 'boxes.dart';
import 'cart.dart';
import 'gift_card.dart';
import '/money.dart';
import '/order_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/cart_model.dart';

class bottomBar extends StatefulWidget {
  const bottomBar({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  State<bottomBar> createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    HomePage(),
    GiftCard(),
    OrderPage(),
    UserProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethomeappbar(),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      persistentFooterButtons: [
        cartinit
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      child: Text("view in cart"),
                      onPressed: () {
                        Get.to(MyCart());
                      }),
                ],
              )
            : Container(),
      ],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: HexColor("#175244")),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.card_giftcard,
              color: HexColor("#175244"),
            ),
            label: 'Gift',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, color: HexColor("#175244")),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: HexColor("#175244")),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: HexColor("#175244"),
        onTap: _onItemTapped,
      ),
    );
  }
}

orderbutton() {
  return FloatingActionButton(
    //Floating action button on Scaffold
    elevation: 10,
    backgroundColor: Color(0xffb036635),
    onPressed: () {
      Get.to(OrderPage(), transition: Transition.downToUp);
    },
    child: Icon(
      Icons.coffee_maker_outlined,
      color: Colors.white,
    ), //icon inside button
  );
}
