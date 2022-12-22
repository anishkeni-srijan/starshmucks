import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/database/menu_db.dart';
import '/menu/widgets/menu_item_list.dart';
import '../common_things.dart';
import '../home/home_screen.dart';
import '../model/menu_model.dart';

class GetSmoothieData extends StatefulWidget {
  const GetSmoothieData(context, {Key? key}) : super(key: key);

  @override
  State<GetSmoothieData> createState() => _GetSmoothieDataState();
}

class _GetSmoothieDataState extends State<GetSmoothieData> {
  late MenuDB db;
  bool getdataf = false;
  List<MenuModel> data = [];
  late FToast fToast;

  @override
  void initState() {
    db = MenuDB();
    db.initDBMenu();
    getIds();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  getSmoothieData() async {
    data = await db.smoothiedata();
    if (mounted) {
      setState(() {
        getdataf = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initcart();
    getSmoothieData();
    return Scaffold(
      persistentFooterButtons: cartinit ? [viewInCart()] : null,
      body: getdataf
          ? MenuItemList(data: data)
          : const CircularProgressIndicator(),
    );
  }
}
