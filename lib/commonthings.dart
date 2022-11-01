import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import '/home_screen.dart';
import '/user_profile.dart';
import 'gift_card.dart';
import '/money.dart';
import '/order_page.dart';
import 'package:flutter/material.dart';



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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: HexColor("#175244")),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard, color: HexColor("#175244"),),
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
