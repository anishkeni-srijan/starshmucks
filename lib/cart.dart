import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:starshmucks/common_things.dart';

import '/db/cart_db.dart';
import '/model/cart_model.dart';
import 'boxes.dart';
import 'address.dart';
import 'db/menu_db.dart';
import 'db/orders_db.dart';
import 'model/menu_model.dart';
import 'model/user_model.dart';
import 'order/order_success.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  bool ischecked = false;
  var result;
  @override
  getcarttotal() {
    // final box = Boxes.getCartData();
    // final data = box.values.toList().cast<CartData>();
    // late double result = 0;
    // for (int index = 0; index < data.length; index++) {
    //   result = result + double.parse(data[index].price) * data[index].qty;
    // }
    // setState(() {});
    // return result;
  }

  late CartDB cartdb;
  late MenuDB menudb;
  late OrdersDB orderdb;
  late List<MenuModel> kart = [];
  late List<MenuModel> kart1 = [];
  late List<CartModel> datalist = [];
  late List<CartModel> qtylist = [];
  List<CartModel> cartlist = [];

  @override
  clearcart() {
    cartdb.clear();
    setState(() {});
  }

  void initState() {
    menudb = MenuDB();
    menudb.initDBMenu();
    cartdb = CartDB();
    cartdb.initDBCart();
    result = getcarttotal();
    super.initState();
  }

  getDataOnIds() async {
    datalist = await cartdb.getDataCart();
    for (var i = 0; i < datalist.length; i++) {
      kart = await menudb.getElementOnId_Menu(datalist[i].id);
      // print("init cart " + kart.length.toString());
      if (kart.length == 1) kart1.add(kart.first);
    }
    setState(() {});
  }

  removefromcart(sendid) {
    cartdb.deleteitem(sendid);
    setState(() {});
  }

  increaseqty(sendid) {
    cartdb.increseqty(sendid);
    setState(() {});
  }

  decreaseqty(sendid) {
    cartdb.decreaseqty(sendid);
    setState(() {});
  }

  putDatafromcart() async {
    orderdb = OrdersDB();
    String idar = '';
    String qtyar = '';
    cartlist = await cartdb.getDataCart();
    for (var i = 0; i < cartlist.length; i++) {
      if (idar.isEmpty) {
        idar = idar + cartlist[i].id.toString();
        qtyar = qtyar + cartlist[i].qty.toString();
      } else {
        idar = idar + ' ' + cartlist[i].id.toString();
        qtyar = qtyar + ' ' + cartlist[i].qty.toString();
      }
    }
    print("im idar:" + idar);
    print("im qtyar:" + qtyar);
    orderdb.createarr(idar, qtyar);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getDataOnIds();
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            putDatafromcart();
            setState(() {});
            Get.to(Address(), transition: Transition.rightToLeft);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(HexColor("#036635"))),
          child: const Text("Checkout"),
          //   ),
          // ],
        ),
      ),

      // })),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: HexColor("#175244"),
        title: const Text("Cart"),
        elevation: 2,
        actions: [
          IconButton(
            color: HexColor("#175244"),
            onPressed: () {
              clearcart();
            },
            icon: const Icon(
              Icons.clear,
            ),
          ),
        ],
      ),
      body: datalist == null
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: datalist.length,
              itemBuilder: (context, index) {
                //print("qty= " + idlist[index].qty.toString());
                return Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            kart1[index].image,
                            height: 100,
                            width: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 150,
                                    child: Text(kart1[index].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis)),
                                Text("\$ " + kart1[index].price),
                                TextButton(
                                  onPressed: () {
                                    removefromcart(datalist[index]);
                                    setState(() {});
                                  },
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              HexColor("#036635"))),
                                  child: const Text(
                                    'Remove',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      if (datalist[index].qty == 1) {
                                        removefromcart(datalist[index]);
                                      } else {
                                        decreaseqty(datalist[index]);
                                      }
                                      setState(() {});
                                    },
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                HexColor("#036635"))),
                                  ),
                                  Text(datalist[index].qty.toString()),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      increaseqty(datalist[index]);
                                      setState(() {});
                                    },
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                HexColor("#036635"))),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
