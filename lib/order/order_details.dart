import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starshmucks/db/user_db.dart';

import '/db/menu_db.dart';
import '/db/orders_db.dart';
import '/model/menu_model.dart';
import '/model/order_history.dart';
import '../help_page.dart';

class Orderdetail extends StatefulWidget {
  const Orderdetail({Key? key}) : super(key: key);

  @override
  State<Orderdetail> createState() => _OrderdetailState();
}

class _OrderdetailState extends State<Orderdetail> {
  late OrdersDB orderdb;
  late int? id = 0;
  List<OrderHistoryModel> orderdata = [];
  List<dynamic> idlistfromstring = [];
  List<dynamic> qtylistfromstring = [];
  List<MenuModel> items = [];
  List<MenuModel> items1 = [];
  late double ttl = 0;
  late double cartttl = 0;
  late double savings = 0;
  double delchar = 5;
  UserDB udb = UserDB();

  @override
  void initState() {
    getOrderId();
    getUser();
    getAddress();

    super.initState();
  }

  List<Map<String, dynamic>> userddt = [];

  getUser() async {
    userddt = await udb.getDataUserData();
    setState(() {});
  }

  getTotal() async {
    final total = await SharedPreferences.getInstance();
    savings = total.getDouble('savings')!;
    for (var i = 0; i < items1.length; i++) {
      cartttl = cartttl + double.parse(items1[i].price);
    }
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
  }

  getOrderId() async {
    final prefs = await SharedPreferences.getInstance();
    id = (await prefs.getInt('orderid'))!;
    await getOrderDetails(id);
    setState(() {});
  }

  getOrderDetails(id) async {
    MenuDB menuDb = MenuDB();
    menuDb.initDBMenu();

    orderdb = OrdersDB();
    orderdb.initDBOrders();
    orderdata = await orderdb.getDataOrderswrtID(id);
    for (var i = 0; i < orderdata.length; i++) {
      idlistfromstring = orderdata[i].id!.split(' ');
      qtylistfromstring = orderdata[i].qty!.split(' ');
    }
    for (var i = 0; i < idlistfromstring.length; i++) {
      items = await menuDb.getitemwithId_order(idlistfromstring[i]);
      items1.add(items.first);
    }
    getTotal();
    setState(() {});
  }

  late String selectedAddress = '';

  getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedAddress = prefs.getString("selectedAddress")!;
    setState(() {});

    return selectedAddress;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeStyle = Theme.of(context);
    double textWidth = MediaQuery.of(context).size.width * 0.45;
    return Scaffold(
      body:    orderdata.isEmpty ||
          items1.isEmpty ||
          qtylistfromstring.isEmpty
          ? Center(child: CircularProgressIndicator())
          :  CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            backgroundColor: Colors.white,
            foregroundColor: HexColor("#175244"),
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Order id: #$id',
                  style: TextStyle(
                    color: HexColor("#175244"),
                  )),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 1,
                            child: Card(
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Deliver To",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: HexColor("#175244"),
                                          fontSize: 18),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'images/map.png',
                                          height: 100,
                                          width: 100,
                                          alignment: Alignment.centerLeft,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(selectedAddress,
                                              softWrap: false,
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16) //new
                                              ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    Container(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            width: MediaQuery.of(context).size.width * 1,
                            child: Card(
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order Summary",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: HexColor("#175244")),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.date_range_outlined,
                                                size: 20.0,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${orderdata[0].date}",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: qtylistfromstring.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 10,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        height: 32,
                                                        width: 32,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: HexColor("#036635"),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            qtylistfromstring[
                                                                    index] +
                                                                "x",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2
                                                                ?.copyWith(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 25),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: textWidth,
                                                            child: Text(
                                                              items1[index]
                                                                  .title
                                                                  .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle1,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: textWidth,
                                                            child: Text(
                                                                "Regular",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption
                                                                    ?.copyWith(
                                                                        color:HexColor("#036635"))),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 4),
                                                    child: Text(
                                                      "\$${items1[index].price}",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w100),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        },
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Subtotal",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "\$${cartttl.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Points savings",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            '- \$$savings',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "Delivery Charges",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            "\$5.00",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      const Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Total",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text(
                                            "\$${ttl.toStringAsFixed(2)}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      const Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                GestureDetector(
                            onTap: () {
                              Get.to(() => const Help());
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
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
