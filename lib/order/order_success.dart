import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';
import 'package:starshmucks/db/cart_db.dart';
import 'package:starshmucks/db/menu_db.dart';
import 'package:starshmucks/db/orders_db.dart';
import 'package:starshmucks/model/menu_model.dart';
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
  late  CartDB cartdb;
  List<OrderHistoryModel> OrderData = [];
  List<CartModel> cartlist = [];
 List<String> idlistfromstring = [];
 List<String> qtylistfromstring = [];
 List<MenuModel> items = [];
 List<MenuModel> items1 = [];


  @override
  void initState() {
    db= OrdersDB();
    db.initDBOrders();
    cartdb = CartDB();
    cartdb.initDBCart();
    getorderid();
    getAddress();
    super.initState();
    cartinit = false;
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
    for (var i =0;i<idlistfromstring.length;i++){
      items = await menudb.getitemwithId_order(idlistfromstring[i]);
      items1.add(items.first);
    }
    setState(() {});
  }
  getorderid() async {
    db.initDBOrders();
    // orderid = db.getOrderId() as List;
    // print('ordid'+orderid.toString());
    // if(orderid.length==1)
    // orderid1.add(orderid.first);
    // setState(() {
    // });

  }

// gainrewards()async{
//   var items = 0;
//   for (var i = 0; i < OrderData.length; i++) {
//     items = items + int.parse(OrderData[i].qty.toString());
//   }
//   var res  = (double.parse(OrderData[0].rewards.toString()) + (items * 10)) as String?;
//
//   print("no. of items " + items.toString());
//   print('total rewards: ' + OrderData[0].rewards.toString());
//   db.initDBOrders();
//   // db.gainrewards(OrderData[0],res);
// }

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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  icon: Icon(
                    Icons.arrow_back,
                    color: HexColor("#175244"),
                  ),
                  label: Text(''),
                  onPressed: () {
                    gohomefromsuccess();
                  },
                ),
                TextButton(
                  child: Text(
                    'Help',
                    style: TextStyle(color: HexColor("#175244")),
                  ),
                  onPressed: () {
                    Get.to(Help());
                  },
                ),
              ],
            ),
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Order details",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                Divider(
                  color: HexColor("#175244"),
                  height: 1,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                ),
                  OrderData.isEmpty || items1.isEmpty ||qtylistfromstring.isEmpty
                          ? Center(child: Text('updating...'),)
                          : SizedBox(
                                width: 400,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:qtylistfromstring.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 5,
                                                top: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        width: 150,
                                                        child: Text(
                                                            items1[index].title.toString(),
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis)),
                                                    Text(
                                                       qtylistfromstring[index]+
                                                            ' x qty'),
                                                  ],
                                                ),
                                                // Column(
                                                //     crossAxisAlignment:
                                                //         CrossAxisAlignment.end,
                                                //     children: [
                                                //       Row(children: [
                                                //         AutoSizeText(
                                                //           "\$ " + data[index].price,
                                                //           minFontSize: 10,
                                                //         ),
                                                //       ]),
                                                //      ])
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),

                              ),


                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Divider(
                    color: HexColor("#175244"),
                    height: 1,
                    thickness: 0.5,
                    indent: 0,
                    endIndent: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cart total",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          // Text(
                          //   "\$ " + data[0].ttlPrice.toStringAsFixed(2),
                          //   style: TextStyle(fontWeight: FontWeight.w300),
                          // ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Points savings",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text(
                            '-\$ 10.00',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery Charges",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "\$ 5.00",
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
                          // Text(
                          //   "\$ " +
                          //       (data[0].ttlPrice - 10.0 + 5.00)
                          //           .toStringAsFixed(2),
                          //   style: TextStyle(fontWeight: FontWeight.w600),
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Divider(
                    color: HexColor("#175244"),
                    height: 1,
                    thickness: 0.5,
                    indent: 0,
                    endIndent: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Deliver to:",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        selectedAddress.toString(),
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    );
  }
}


