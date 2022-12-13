import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_things.dart';
import '../db/menu_db.dart';
import '../model/menu_model.dart';
import '/db/orders_db.dart';
import '/model/order_history.dart';
import 'order_details.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  late Map<dynamic, dynamic> data = {};
  late List<dynamic> data1 = [];
  late OrdersDB orderdb;
  List<dynamic> idlistfromstring = [];
  List<dynamic> qtylistfromstring = [];
  List<MenuModel> items = [];
  List<MenuModel> items1 = [];
  List<OrderHistoryModel> orderdata = [];
  getorderdetails(id) async {
    MenuDB menudb = MenuDB();
    menudb.initDBMenu();
    orderdb = OrdersDB();
    orderdb.initDBOrders();
    orderdata = await orderdb.getDataOrderswrtID(id);
    for (var i = 0; i < orderdata.length; i++) {
      idlistfromstring = orderdata[i].id!.split(' ');
      qtylistfromstring = orderdata[i].qty!.split(' ');
    }
    for (var i = 0; i < idlistfromstring.length; i++) {
      items = await menudb.getitemwithId_order(idlistfromstring[i]);
      items1.add(items.first);
    }
    getttl();
    setState(() {});
  }

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
      appBar: gethomeappbar("Orders", [Container()], true, 0.0),
      body: data1.isEmpty
          ? Center(
              child: Text(
              "No Orders Found",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: HexColor("#175244")),
            ))
          : ListView.separated(
              itemCount: data1.length,
              itemBuilder: (context, index) {
                var res = index + 1;
                getorderdetails(res);
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
                      radius: 50,
                      child: items1.isEmpty
                          ? Text("S1")
                          : Image.asset(
                              items1[index].image,
                              height: 80,
                              width: 80,
                            ),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    title: Text(
                      "Order id: #" + res.toString(),
                      style:
                          TextStyle(fontSize: 16, color: HexColor("#175244")),
                    ),
                    subtitle: Text("Order Placed",
                        style: TextStyle(fontSize: 16, color: Colors.black38)),
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
