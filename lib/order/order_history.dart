import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';

import '/db/orders_db.dart';
import '/model/order_history.dart';
import 'order_details.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var idlistfromstring;
  var qtylistfromstring;
  late Map<dynamic, dynamic> data = {};
  late List<dynamic> data1 = [];
  List<OrderHistoryModel> Orderdata = [];
  late OrdersDB orderdb;
  @override
  void initState() {
    orderdb = OrdersDB();
    orderdb.initDBOrders();
    getorderdata();
    super.initState();
  }

  getorderdata() async {
    data = await orderdb.getalldata();
    data1.addAll(data.keys);

    // print("order ids: "+ data.keys.toString());
    // data1.addAll(data);
    // print(data1);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyle(
            color: HexColor("#175244"),
          ),
        ),
        titleSpacing: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: HexColor("#175244")),
      ),
      body: ListView.builder(
          itemCount: data1.length,
          itemBuilder: (context, index) {
            var res = index + 1;
            return ListTile(
                title: Text(res.toString()),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setInt('orderid', res);
                  Get.to(transition: Transition.rightToLeft, Orderdetail());
                },
           );
          }),
    );
  }
}
