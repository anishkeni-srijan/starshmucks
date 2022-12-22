import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/database/menu_db.dart';
import '/menu/widgets/menu_item_list.dart';
import '../common_things.dart';
import '../home/home_screen.dart';
import '../model/menu_model.dart';

class GetCakeData extends StatefulWidget {
  const GetCakeData({Key? key}) : super(key: key);

  @override
  State<GetCakeData> createState() => _GetCakeDataState();
}

class _GetCakeDataState extends State<GetCakeData> {
  late MenuDB db;
  bool getdataf = false;
  List<MenuModel> data = [];
  late FToast fToast;

  @override
  void initState() {
    db = MenuDB();
    db.initDBMenu();
    getCakeData();
    getIds();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  getCakeData() async {
    data = await db.cakedata();
    if (mounted) {
      setState(() {
        getdataf = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initcart();
    getCakeData();
    return Scaffold(
        persistentFooterButtons: cartinit ? [viewInCart()] : null,
        body: MenuItemList(data: data, fToast: fToast));
  }
}
