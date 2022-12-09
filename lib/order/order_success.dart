import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

import 'package:get/get.dart';
import 'package:starshmucks/db/cart_db.dart';
import 'package:starshmucks/db/menu_db.dart';
import 'package:starshmucks/db/orders_db.dart';
import 'package:starshmucks/model/menu_model.dart';
import '../db/user_db.dart';
import '../help_page.dart';
import '../model/cart_model.dart';
import '/model/order_history.dart';
import '/common_things.dart';
import '/home/home_screen.dart';

class OrderSuccess extends StatefulWidget {
  OrderSuccess({Key? key}) : super(key: key);
  @override
  _OrderSuccessState createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  late OrdersDB db;
  late CartDB cartdb;
  List<OrderHistoryModel> OrderData = [];
  List<CartModel> cartlist = [];
  List<String> idlistfromstring = [];
  List<String> qtylistfromstring = [];
  List<MenuModel> items = [];
  List<MenuModel> items1 = [];
  late double ttl = 0;
  late double cartttl = 0;
  late double savings = 0;
  late UserDB udb;
  double delchar = 5;
  late int orderid = 0;

  @override
  void initState() {
    udb = UserDB();
    udb.initDBUserData();
    db = OrdersDB();
    db.initDBOrders();
    cartdb = CartDB();
    cartdb.initDBCart();
    getUser();
    getttl();
    getorderid();
    getAddress();
    super.initState();

    cartinit = false;
  }

  List<Map<String, dynamic>> userddt = [];
  getUser() async {
    userddt = await udb.getDataUserData();
    setState(() {});
  }

  getttl() async {
    final total = await SharedPreferences.getInstance();
    cartttl = total.getDouble('total')!;
    savings = total.getDouble('savings')!;
    if (userddt[0]['tier'] == 'bronze') {
      ttl = (cartttl + delchar) - savings;
    } else if (userddt[0]['tier'] == 'silver') {
      if (cartttl > 50.0) {
        ttl = (cartttl) - savings;
      } else {
        ttl = (cartttl + delchar) - savings;
      }
    } else {
      ttl = (cartttl) - savings;
    }
    setState(() {});
  }

  getDataIds() async {
    MenuDB menudb = MenuDB();
    menudb.initDBMenu();
    db.initDBOrders();
    OrderData = await db.getDataOrders();
    for (var i = 0; i < OrderData.length; i++) {
      idlistfromstring = OrderData[i].id!.split(' ');
      qtylistfromstring = OrderData[i].qty!.split(' ');
    }
    for (var i = 0; i < idlistfromstring.length; i++) {
      items = await menudb.getitemwithId_order(idlistfromstring[i]);
      items1.add(items.first);
    }
    setState(() {});
  }

  getorderid() async {
    db.initDBOrders();
    Map<dynamic, dynamic> orderlist = await db.getalldata();
    orderid = orderlist.length;
    print(orderid);
    // if(orderid.length==1)
    // orderid1.add(orderid.first);
    setState(() {});
  }

  late String selectedAddress = '';
  getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedAddress = prefs.getString("selectedAddress")!;
    setState(() {});
    print("test " + selectedAddress);
    return selectedAddress;
  }

  @override
  Widget build(BuildContext context) {
    getDataIds();
    return WillPopScope(
      onWillPop: gohomefromsuccess,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: TextButton.icon(
            icon: Icon(
              Icons.arrow_back,
              color: HexColor("#175244"),
            ),
            label: Text(''),
            onPressed: () {
              gohomefromsuccess();
            },
          ),
          title: Text("Order details"),
          backgroundColor: Colors.white,
          foregroundColor: HexColor("#175244"),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: HexColor("#175244"),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.05),
                    BlendMode.dstATop,
                  ),
                  image: ExactAssetImage('images/shmucks.png'),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    transform: Matrix4.translationValues(0, 12, 0),
                    child: Text(
                      'Order id:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, 28, 0),
                    child: Text(
                      'Order Placed!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Container(
                      transform: Matrix4.translationValues(0, 40, 0),
                      child: AutoSizeText(
                        'Your order will take 30-35mins',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
            OrderData.isEmpty || items1.isEmpty || qtylistfromstring.isEmpty
                ? Center(
                    child: Text('updating...'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 8,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Order placed",
                                  style: TextStyle(fontSize: 22),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "on " + OrderData[0].date.toString(),
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Text(
                                      "items: " +
                                          idlistfromstring.length.toString(),
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: qtylistfromstring.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        bottom: Platform.isIOS ? 0 : 20,
                                        top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        qtylistfromstring.isEmpty ||
                                                items1.isEmpty
                                            ? const Center(
                                                child: Text('updating...'),
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: 150,
                                                      child: Text(
                                                          items1[index]
                                                              .title
                                                              .toString(),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                                  Text(
                                                      qtylistfromstring[index] +
                                                          ' x qty'),
                                                ],
                                              ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(children: [
                                                Text(
                                                  "\$ ${items1[index].price}",
                                                ),
                                              ]),
                                            ])
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

            // Text(
            //   "\$ " + data[0].ttlPrice.toStringAsFixed(2),
            //   style: TextStyle(fontWeight: FontWeight.w300),
            // ),

            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Cart total",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$ ${cartttl.toStringAsFixed(2)}",
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Points savings",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text(
                            '-\$${savings.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Delivery Charges",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "\$ ${delchar.toStringAsFixed(2)}",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "\$ ${ttl.toStringAsFixed(2)}",
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Deliver To",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(selectedAddress),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => Help());
              },
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                width: MediaQuery.of(context).size.width * 1,
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "Need Help?",
                          style: TextStyle(
                              color: HexColor("#175244"),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        )),
      ),
    );
  }
}
