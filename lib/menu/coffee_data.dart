import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/database/menu_db.dart';
import '/menu/widgets/menu_item_list.dart';
import '../common_things.dart';
import '../home/home_screen.dart';
import '../model/cart_model.dart';
import '../model/menu_model.dart';

class GetCoffeeData extends StatefulWidget {
  const GetCoffeeData({Key? key}) : super(key: key);

  @override
  State<GetCoffeeData> createState() => _GetCoffeeDataState();
}

class _GetCoffeeDataState extends State<GetCoffeeData> {
  late MenuDB menuDB;
  bool getdataf = false;
  List<MenuModel> data = [];
  late MenuDB db;
  late FToast fToast;

  @override
  void initState() {
    getCartData1();
    menuDB = MenuDB();
    menuDB.initDBMenu();
    getCoffeeData();
    getIds();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  List<CartModel> cartData = [];

  getCartData1() async {
    cartData = await cdb.getDataCart();
    if (mounted) {
      setState(() {});
    }
  }

  getCoffeeData() async {
    data = await menuDB.coffeedata();
    if (mounted) {
      setState(() {
        getdataf = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initcart();
    getCoffeeData();
    return Scaffold(
      persistentFooterButtons: cartinit ? [viewInCart()] : null,
      body: getdataf
          ? MenuItemList(data: data)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
