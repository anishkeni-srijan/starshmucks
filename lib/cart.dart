import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:starshmucks/db/cart_db.dart';
import 'package:starshmucks/model/cartDBModel.dart';

import 'boxes.dart';
import 'address.dart';
import 'home/home_screen.dart';

import 'db/menu_db.dart';
import 'model/menu_model.dart';
import 'model/user_model.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  bool ischecked = false;
  var result;
  @override
  void dispose() {
    Hive.box('cartdata').close();
    super.dispose();
  }

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
  List<Menu> kart = [];
  List<Menu> kart1 = [];
  List<CartModel> idlist = [];

  @override
  void initState() {
    menudb = MenuDB();
    menudb.initDBMenu();
    cartdb = CartDB();
    cartdb.initDBCart();
    result = getcarttotal();
    getDataOnIds();
    super.initState();
  }

  getDataOnIds() async {
    idlist = await cartdb.getDataCart();
    print("size" + idlist.length.toString());
    // kart= await menudb.ffeedata(1); // prints product at id 1
    //logic for sending ids from cart list to get details from menu db
    for (var i = 0; i < idlist.length; i++) {
      kart = await menudb.fefe(idlist[i].id);
      print("init cart " + kart.length.toString());
      if (kart.length == 1) kart1.add(kart.first);

      //print("fdg " + kart.runtimeType.toString());
      print("added to cart: " + kart1.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final box2 = Boxes.getUserData();
    final data2 = box2.values.toList().cast<UserData>();

    // final box = Boxes.getCartData();
    // final data = box.values.toList().cast<CartData>();
    return Scaffold(
      bottomNavigationBar:
          //
          // data.isEmpty
          //     ? Center(child: Text("No items in cart"))
          Container(
        padding: EdgeInsets.all(8.0),
        child:
            // ValueListenableBuilder<Box<CartData>>(
            //     valueListenable: Boxes.getCartData().listenable(),
            //     builder: (context, box, _) {
            //       final data = box.values.toList().cast<CartData>();
            //       late double result = 0;
            //       for (int index = 0; index < data.length; index++) {
            //         result = result +
            //             double.parse(data[index].price) * data[index].qty;
            //       }
            //
            //       //change to index
            //       data[0].ttlPrice = result;
            //       box.putAt(0, data[0]);
            //       return Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           result == null || data.isEmpty
            //               ? Text(
            //                   "Total: \$0.00",
            //                   style: TextStyle(
            //                       fontSize: 22.0,
            //                       fontWeight: FontWeight.bold),
            //                 )
            //               : Text(
            //                   "Total: \$" + result.toStringAsFixed(2),
            //                   style: TextStyle(
            //                       fontSize: 22.0,
            //                       fontWeight: FontWeight.bold),
            //                 ),
            ElevatedButton(
          onPressed: () {
            Get.to(Address(), transition: Transition.rightToLeft);
          },
          child: Text("Checkout"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(HexColor("#036635"))),
          //   ),
          // ],
        ),
      ),

      // })),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: HexColor("#175244"),
        title: Text("Cart"),
        elevation: 2,
      ),
      body: ListView.builder(
        itemCount: kart1.length,
        itemBuilder: (context, index) {
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
                              // box.delete(data[index].key);
                              // data[index].isInCart = false;
                              setState(() {});
                            },
                            style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(
                                    HexColor("#036635"))),
                            child: Text(
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
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                // if (data[index].qty == 1) {
                                //   box.delete(data[index].key);
                                //   data[index].isInCart = false;
                                // } else {
                                //   data[index].qty = data[index].qty - 1;
                                //   box.putAt(index, data[index]);
                                // }
                                setState(() {});
                              },
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      HexColor("#036635"))),
                            ),
                            // Text(data[index].qty.toString()),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                // data[index].qty = data[index].qty + 1;
                                // box.putAt(index, data[index]);
                                setState(() {});
                              },
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
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
