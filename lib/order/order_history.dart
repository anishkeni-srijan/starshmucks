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
      body: ListView.separated(
          itemCount: data1.length,
          itemBuilder: (context, index) {
            var res = index + 1;
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: ListTile(
                trailing: TextButton.icon(
                    onPressed: () {
                      getdetails(res);
                    },
                    icon: (Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black38,
                    )),
                    label: Text("")),
                leading: CircleAvatar(
                  backgroundColor: const Color(0xff6ae792),
                  child: Text(
                    "d",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                contentPadding: EdgeInsets.all(10),
                title: Text(
                  "Order id: #" + res.toString(),
                  style: TextStyle(fontSize: 14, color: HexColor("#175244")),
                ),
                subtitle: Text("Order Placed",
                    style: TextStyle(fontSize: 14, color: Colors.black38)),
                onTap: () async {
                  getdetails(res);
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 2,
            );
          }),
    );
  }
}

getdetails(res) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('orderid', res);
  Get.to(transition: Transition.rightToLeft, () => Orderdetail());
}
