import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:starshmucks/db/user_db.dart';
import 'dart:io' show Platform;
import '../help_page.dart';
import '/db/menu_db.dart';
import '/db/orders_db.dart';
import '/model/menu_model.dart';
import '/model/order_history.dart';

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
    getorderid();
    getUser();
    getAddress();
    super.initState();
  }
  List<Map<String, dynamic>> userddt = [];
  getUser() async {
    userddt = await udb.getDataUserData();
    getttl();
    setState(() {});
  }

  getttl() async{
    final total = await SharedPreferences.getInstance();
    cartttl = total.getDouble('total')!;
    savings = total.getDouble('savings')!;
    if(userddt[0]['tier'] =='bronze'){

      ttl=(cartttl+delchar) - savings;
    }
    else if(userddt[0]['tier'] =='silver'){
      if(cartttl>50.0){

        ttl=(cartttl) - savings;
      }
      else{

        ttl=(cartttl+delchar) - savings;
      }
    }
    else{
      ttl=(cartttl) - savings;
    }
    setState(() {
    });
  }
  getorderid() async {
    final prefs = await SharedPreferences.getInstance();
    id = (await prefs.getInt('orderid'))!;
    setState(() {});
  }

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
    setState(() {});
  }

  late String selectedAddress = '';
  getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedAddress = prefs.getString("selectedAddress")!;
    setState(() {});

    return selectedAddress;
  }

  Widget build(BuildContext context) {
    getorderdetails(id);
    return Scaffold(
      body: CustomScrollView(
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
              title: Text('Order id: #' + id.toString(),
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
                    orderdata.isEmpty ||
                            items1.isEmpty ||
                            qtylistfromstring.isEmpty
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              "on " +
                                                  orderdata[0].date.toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            Text(
                                              "items: " +
                                                  idlistfromstring.length
                                                      .toString(),
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: qtylistfromstring.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                bottom: Platform.isIOS ? 0 : 20,
                                                top: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                qtylistfromstring.isEmpty ||
                                                        items1.isEmpty
                                                    ? const Center(
                                                        child:
                                                            Text('updating...'),
                                                      )
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                              width: 150,
                                                              child: Text(
                                                                  items1[index]
                                                                      .title
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis)),
                                                          Text(
                                                              qtylistfromstring[
                                                                      index] +
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


                    Container(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      width: MediaQuery.of(context).size.width * 1,
                      child: Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Cart total",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$ " + cartttl.toStringAsFixed(2),
                                    style: TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children:[
                                  const Text(
                                    "Points savings",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    '-\$ ${savings}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Delivery Charges",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    "\$ 5.00",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Amount",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "\$ " +ttl.toStringAsFixed(2),
                                    style: TextStyle(fontWeight: FontWeight.w600),
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

                    SizedBox(
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
