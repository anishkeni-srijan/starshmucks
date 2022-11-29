import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';

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

  @override
  void initState() {
    getorderid();
    super.initState();
  }

  getorderid() async {
    final prefs = await SharedPreferences.getInstance();
    id = (await prefs.getInt('orderid'))!;
    setState(() {});
  }

  getorderdetails(id) async {
    MenuDB menudb = MenuDB();
    menudb.initDBMenu();
    print("sending id to db:" + id.toString());
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
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 1,
                      child: Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Amount paid:",
                                style: TextStyle(fontSize: 22),
                              ),
                              Text(
                                "Mode of payment:",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
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
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "on Wednesday ,08 September",
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
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: 20,
                                          top: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          orderdata.isEmpty || items1.isEmpty
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
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis)),
                                                    Text(qtylistfromstring[
                                                            index] +
                                                        ' x qty'),
                                                  ],
                                                ),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(children: const [
                                                  Text(
                                                    "\$ ",
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
                              const Text(
                                "Order Details",
                                style: TextStyle(fontSize: 22),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Cart total",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                  // Text(
                                  //   "\$ " + data[0].ttlPrice.toStringAsFixed(2),
                                  //   style: TextStyle(fontWeight: FontWeight.w300),
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Points savings",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    '-\$ 10.00',
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
                                children: const [
                                  Text(
                                    "Total Amount",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  // Text(
                                  //   "\$ " +
                                  //       (data[0].ttlPrice - 10.0 + 5.00)
                                  //           .toStringAsFixed(2),
                                  //   style: TextStyle(fontWeight: FontWeight.w600),
                                  // ),
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
                          child: Text("Deliver to:"),
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
                          child: Text("Deliver to:"),
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
                          child: Text("Deliver to:"),
                        ),
                      ),
                    )
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
