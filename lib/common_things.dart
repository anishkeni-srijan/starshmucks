import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '/home_screen.dart';
import '/user_profile.dart';
import 'boxes.dart';
import 'cart.dart';
import '/order_page.dart';
import 'gift_card.dart';
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

gethomeappbar() {
  return AppBar(
    backgroundColor: Colors.white,
    title: Text(
      'Starschmucks',
      style: TextStyle(
        color: HexColor("#175244"),
        fontWeight: FontWeight.w600,
      ),
    ),
    elevation: 0,
    actions: [
      // IconButton(
      //   color: HexColor("#175244"),
      //   onPressed: () {
      //     Get.to(MyCart());
      //   },
      //   icon: const Icon(
      //     Icons.shopping_cart,
      //   ),
      // ),
    ],
    automaticallyImplyLeading: false,
  );
}

increaseqty(index) {
  ValueListenableBuilder<Box<CartData>>(
      valueListenable: Boxes.getCartData().listenable(),
      builder: (context, box, _) {
        final data = box.values.toList().cast<CartData>();
        data[index].qty = data[index].qty + 1;
        box.putAt(index, data[index]);
        return Container();
      });
}

viewincart() {
  final box = Boxes.getCartData();
  final data = box.values.toList().cast<CartData>();
  var size = data.length;
  late double result = 0;
  for (int index = 0; index < data.length; index++) {
    result = result + double.parse(data[index].price) * data[index].qty;
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        children: [
          Text(size.toString()),
          size < 2
              ? Text(
                  "item |",
                  style: TextStyle(color: HexColor("#036635")),
                )
              : Text(
                  "items |",
                  style: TextStyle(color: HexColor("#036635")),
                ),
          Text(
            "\$" + result.toString(),
            style: TextStyle(color: HexColor("#036635")),
          ),
        ],
      ),
      TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color?>(HexColor("#036635")),
            foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
          ),
          child: Text(
            "View in Cart",
          ),
          onPressed: () {
            Get.to(MyCart(), transition: Transition.downToUp);
          }),
    ],
  );
}


