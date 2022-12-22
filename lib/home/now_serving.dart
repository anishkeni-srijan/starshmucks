import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/database/menu_db.dart';
import '/home/widgets/home_item_list.dart';
import '../common_things.dart';
import '../model/menu_model.dart';

class NowServing extends StatefulWidget {
  const NowServing({Key? key}) : super(key: key);

  @override
  State<NowServing> createState() => _NowServingState();
}

class _NowServingState extends State<NowServing> {
  late MenuDB db;
  bool getdataf = false;
  List<MenuModel> nowdata = [];
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

  getdata() async {
    nowdata = await db.nowServeData();
    if (mounted) {
      setState(() {
        getdataf = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.18,
        child: HomeItemList(data: nowdata, fToast: fToast));
  }
}
