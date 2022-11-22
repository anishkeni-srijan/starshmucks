import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sqflite/sqflite.dart';
import 'package:starshmucks/order_success.dart';

import 'home/home_screen.dart';
import '/user_profile.dart';
import 'boxes.dart';
import 'cart.dart';
import 'db/menu_db.dart';
import 'model/menu_model.dart';
import 'order/order_page.dart';
import 'gift_card.dart';
import 'order_success.dart';
import 'order_failed.dart';

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
      IconButton(
        color: HexColor("#175244"),
        onPressed: () {
          Get.to(MyCart());
        },
        icon: const Icon(
          Icons.shopping_cart,
        ),
      ),
    ],
    automaticallyImplyLeading: false,
  );
}

increaseqty(index) {
  // qty[index] = qty[index]+1;
}

viewincart() {
  // final box = Boxes.getCartData();
  // final data = box.values.toList().cast<CartData>();
  // var size = data.length;
  // late double result = 0;
  // for (int index = 0; index < data.length; index++) {
  //   result = result + double.parse(data[index].price) * data[index].qty;
  // }
  // return Row(
  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   crossAxisAlignment: CrossAxisAlignment.center,
  //   children: [
  //     Row(
  //       children: [
  //         Text(
  //           size.toString(),
  //           style: TextStyle(
  //               color: HexColor("#036635"), fontWeight: FontWeight.w600),
  //         ),
  //         size < 2
  //             ? Text(
  //                 " item | ",
  //                 style: TextStyle(color: HexColor("#036635")),
  //               )
  //             : Text(
  //                 " items | ",
  //                 style: TextStyle(color: HexColor("#036635")),
  //               ),
  //         Text(
  //           "\$" + result.toStringAsFixed(2),
  //           style: TextStyle(
  //               color: HexColor("#036635"), fontWeight: FontWeight.w600),
  //         ),
  //       ],
  //     ),
  //     TextButton(
  //         style: ButtonStyle(
  //           backgroundColor:
  //               MaterialStateProperty.all<Color?>(HexColor("#036635")),
  //           foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
  //         ),
  //         child: Text(
  //           "View in Cart",
  //         ),
  //         onPressed: () {
  //           Get.to(MyCart(), transition: Transition.downToUp);
  //         }),
  //   ],
  // );
}

Future<bool> gohome() async {
  // final box = Boxes.getCartData();
  // final data = box.values.toList().cast<CartData>();
  // box.clear();

  return (await Get.to(bottomBar())) ?? false;
}

goToSuccess() {
  return Get.to(Ordersuccess());
}

goToFailed(String message) {
  return Get.to(OrderFail(message));
}
