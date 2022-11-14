import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';

import 'boxes.dart';
import 'address.dart';
import '/home_screen.dart';
import '/model/cart_model.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  var result;
  @override
  void dispose() {
    Hive.box('cartdata').close();
    super.dispose();
  }

  getcarttotal() {
    final box = Boxes.getCartData();
    final data = box.values.toList().cast<CartData>();
    late double result = 0;
    for (int index = 0; index < data.length; index++) {
      result = result + double.parse(data[index].price) * data[index].qty;
    }
    setState(() {});
    return result;
  }

  @override
  void initState() {
    result = getcarttotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          padding: EdgeInsets.all(8.0),
          child: ValueListenableBuilder<Box<CartData>>(
              valueListenable: Boxes.getCartData().listenable(),
              builder: (context, box, _) {
                final data = box.values.toList().cast<CartData>();
                late double result = 0;
                for (int index = 0; index < data.length; index++) {
                  result = result +
                      double.parse(data[index].price) * data[index].qty;
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    result == null || data.isEmpty
                        ? Text(
                            "Total: \$0.00",
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "Total: \$" + result.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(Address(), transition: Transition.rightToLeft);
                      },
                      child: Text("Checkout"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(HexColor("#036635"))),
                    ),
                  ],
                );
              })),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: HexColor("#175244"),
        title: Text("Cart"),
      ),
      body: ValueListenableBuilder<Box<CartData>>(
          valueListenable: Boxes.getCartData().listenable(),
          builder: (context, box, _) {
            final data = box.values.toList().cast<CartData>();
            if (data.isEmpty) {
              cartinit = false;
            }
            return data.isEmpty
                ? Center(child: Text("No items in cart"))
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                data[index].image,
                                height: 100,
                                width: 100,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 150,
                                        child: Text(data[index].title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis)),
                                    Text("\$ " + data[index].price),
                                    TextButton(
                                      child: Text('Remove'),
                                      onPressed: () {
                                        box.delete(data[index].key);
                                        data[index].isInCart = false;
                                        setState(() {});
                                      },
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  HexColor("#036635"))),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          if (data[index].qty == 1) {
                                            box.delete(data[index].key);
                                            data[index].isInCart = false;
                                          } else {
                                            data[index].qty =
                                                data[index].qty - 1;
                                            box.putAt(index, data[index]);
                                          }
                                          setState(() {});
                                        },
                                        style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    HexColor("#036635"))),
                                      ),
                                      Text(data[index].qty.toString()),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          data[index].qty = data[index].qty + 1;
                                          box.putAt(index, data[index]);
                                          setState(() {});
                                        },
                                        style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    HexColor("#036635"))),
                                      ),
                                    ]),
                                  ]),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: HexColor("#036635"),
                              height: 1,
                              thickness: 0.5,
                              indent: 0,
                              endIndent: 0,
                            ),
                          ),
                        ],
                      );
                    },
                  );
          }),
      //
    );
  }
}
