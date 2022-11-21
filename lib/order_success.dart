import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:starshmucks/common_things.dart';
import 'package:starshmucks/home_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';
import 'package:starshmucks/model/orderHistory.dart';
import 'package:starshmucks/model/user_model.dart';

import 'boxes.dart';
import 'db/Database.dart';
import 'help_page.dart';
import 'model/cart_model.dart';

class Ordersuccess extends StatefulWidget {
  Ordersuccess({Key? key}) : super(key: key);

  @override
  _OrdersuccessState createState() => _OrdersuccessState();
}

class _OrdersuccessState extends State<Ordersuccess> {
  late DB db;
  late var item;
  List<OrderHistory> OrderData = [];
  @override
  void initState() {
    db = DB();
    db.initDBOrders();
    putdata();
    gainrewards();
    getAddress();
    printData();
    super.initState();
    cartinit = false;
  }

  printData() {
    print("testty " + OrderData.toString());
    for (var i = 0; i < OrderData.length; i++) {
      print("Titlke is " + OrderData[i].title);
    }
  }

  putdata() async {
    final box = Boxes.getCartData();
    final data = box.values.toList().cast<CartData>();
    for (var index = 0; index < data.length; index++) {
      db.insertDataOrders(OrderHistory(
          title: data[index].title,
          price: data[index].price,
          qty: data[index].qty,
          isInCart: data[index].isInCart,
          image: data[index].image,
          ttlPrice: data[index].ttlPrice,
          id: data[index].id));
    }
  }

  getdata() async {
    OrderData = await db.getDataOrders();
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
    // final box2 = Boxes.getUserData();
    // final data2 = box2.values.toList().cast<UserData>();
    final box = Boxes.getCartData();
    final data = box.values.toList().cast<CartData>();
    //
    // //to copy list
    //  data2[0].orders = data.cast<List>();
    return WillPopScope(
      onWillPop: gohome,
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
                    box.clear();
                    Get.to(bottomBar());
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
                ValueListenableBuilder<Box<CartData>>(
                    valueListenable: Boxes.getCartData().listenable(),
                    builder: (context, box, _) {
                      final data = box.values.toList().cast<CartData>();
                      if (data.isEmpty) {
                        cartinit = false;
                      }
                      return data.isEmpty
                          ? Center(child: Text("No items in cart"))
                          : SizedBox(
                              width: 400,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
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
                                                        data[index].title,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis)),
                                                Text(
                                                    data[index].qty.toString() +
                                                        ' x qty'),
                                              ],
                                            ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(children: [
                                                    AutoSizeText(
                                                      "\$ " + data[index].price,
                                                      minFontSize: 10,
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
                            );
                    }),
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
                          Text(
                            "\$ " + data[0].ttlPrice.toStringAsFixed(2),
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
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
                          Text(
                            "\$ " +
                                (data[0].ttlPrice - 10.0 + 5.00)
                                    .toStringAsFixed(2),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
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

gainrewards() {
  final box = Boxes.getUserData();
  final data = box.values.toList().cast<UserData>();

  final box2 = Boxes.getCartData();
  final datab = box2.values.toList().cast<CartData>();
  var items = 0;
  for (var i = 0; i < datab.length; i++) {
    items = items + datab[i].qty;
  }
  print("before" + data[0].rewards.toString());
  data[0].rewards = data[0].rewards!.toDouble() + (items * 10);
  print("no. of items " + items.toString());
  box.putAt(0, data[0]);
  print('total rewards: ' + data[0].rewards.toString());
}
