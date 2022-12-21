import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/db/cart_db.dart';
import '/model/cart_model.dart';
import '/user_profile.dart';
import 'cart.dart';
import 'db/user_db.dart';
import 'gift_card.dart';
import 'home/home_screen.dart';
import 'menu/menu_page.dart';
import 'model/user_model.dart';
import 'order/order_failed.dart';
import 'order/order_success.dart';
import 'wishlist.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    const HomePage(),
    const GiftCard(),
    const MenuPage(),
    const UserProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit this app'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No', style: TextStyle(color: HexColor("#175244"))),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: Text(
                  'Yes',
                  style: TextStyle(color: HexColor("#175244")),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: gethomeappbar(
            "Starschmucks",
            [
              IconButton(
                color: HexColor("#175244"),
                onPressed: () {
                  Get.to(() => const WishListPage());
                },
                icon: const Icon(
                  Icons.favorite,
                ),
              )
            ],
            false,
            10.0),
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
      ),
    );
  }
}

var route;

gethomeappbar(title, action, automaticallyImplyLeadingStatus, ttlspacing) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Text(
      title,
      style: TextStyle(
        color: HexColor("#175244"),
        fontWeight: FontWeight.w600,
      ),
    ),
    elevation: 0,
    actions: action,
    automaticallyImplyLeading: automaticallyImplyLeadingStatus,
    foregroundColor: HexColor("#175244"),
    titleSpacing: ttlspacing,
  );
}

late double ttl;
double savings = 0;
var size = 0;

getdata() async {
  CartDB cdb = CartDB();
  List<CartModel> data = await cdb.getDataCart();
  size = data.length;
}

getttl() async {
  final total = await SharedPreferences.getInstance();
  ttl = total.getDouble('total') ?? 0;
  savings = total.getDouble('savings') ?? 0;
}

viewincart() {
  getttl();
  getdata();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        children: [
          Text(
            size.toString(),
            style: TextStyle(
                color: HexColor("#036635"), fontWeight: FontWeight.w600),
          ),
          if (size < 2)
            Text(
              " item",
              style: TextStyle(
                color: HexColor("#036635"),
              ),
            )
          else
            Text(
              " items",
              style: TextStyle(
                color: HexColor("#036635"),
              ),
            ),
        ],
      ),
      TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color?>(HexColor("#036635")),
            foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
          ),
          child: const Text(
            "View in Cart",
          ),
          onPressed: () {
            Get.to(() => MyCart(), transition: Transition.downToUp);
          }),
    ],
  );
}

initcart() async {
  CartDB cdb = CartDB();
  cdb.initDBCart();
  List<CartModel> datal = await cdb.getDataCart();
  datal.isEmpty ? cartinit = false : cartinit = true;
}

Future<bool> gohome() async {
  return (await Get.to(() => BottomBar())) ?? false;
}

Future<bool> gohomefromsuccess() async {
  calcrewards();
  CartDB cartdb = CartDB();
  cartdb.clear();
  return (await Get.to(() => BottomBar())) ?? false;
}

goToSuccess() {
  return Get.to(() => OrderSuccess());
}

goToFailed(String message) {
  return Get.to(() => OrderFail(message));
}

calcrewards() async {
  late double res = 0;
  UserDB udb = UserDB();
  List<Map<String, dynamic>> usernames = [];
  usernames = await udb.getDataUserData();
  if (usernames[0]['tier'] == 'bronze') {
    res = usernames[0]['rewards'] + (ttl / 10) - (savings * 2);
  } else if (usernames[0]['tier'] == 'silver') {
    res = (usernames[0]['rewards'] + ((ttl / 10) * 1.5) - (savings * 2));
  } else if (usernames[0]['tier'] == 'gold') {
    res = (usernames[0]['rewards'] + ((ttl / 10) * 2) - (savings * 2));
  } else {
    res = usernames[0]['rewards'] + (ttl / 10) - (savings * 2);
  }

  var rewardUpdate = UserModel(
    rewards: res,
    tier: res > 10 && res < 20
        ? 'silver'
        : res > 20
            ? 'gold'
            : 'bronze',
    dob: usernames[0]['dob'],
    email: usernames[0]['email'],
    name: usernames[0]['name'],
    password: usernames[0]['password'],
    phone: usernames[0]['phone'],
    tnc: usernames[0]['tnc'],
    image: usernames[0]['image'],
  );

  udb.updaterewards(rewardUpdate);
}

class CustomToast extends StatelessWidget {
  const CustomToast(
    String this.toastMessage,
  );

  final String toastMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: HexColor("#036635"),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check,
            color: Colors.white,
          ),
          const SizedBox(width: 12.0),
          Text(
            toastMessage,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
