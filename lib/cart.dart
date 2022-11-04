import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:starshmucks/home_screen.dart';
import 'package:starshmucks/model/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:starshmucks/providers/offers_provider.dart';

import 'boxes.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  void dispose() {
    Hive.box('cartdata').close();
    super.dispose();
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
                  result = result + double.parse(data[index].price);
                }
                return Row(
                  children: [
                    Text(
                      "Total: \$" + result.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 120,
                    ),
                    ElevatedButton(onPressed: () {}, child: Text("Checkout")),
                  ],
                );
              })),
      appBar: AppBar(
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
                ? Text("No data in cart")
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Image.asset(
                            data[index].image,
                            height: 100,
                            width: 100,
                          ),
                          Column(
                            children: [
                              Text(data[index].title),
                              Text("\$ " + data[index].price),
                              Text("Quntity: " + data[index].qty.toString()),
                              TextButton(
                                  onPressed: () {
                                    box.delete(data[index].key);
                                    data[index].isInCart = false;
                                    setState(() {});
                                  },
                                  child: Text('Remove'))
                            ],
                          ),
                        ],
                      );
                    },
                  );

            //   Column(
            //   children: [
            //     Text(data.length.toString()),
            //     TextButton(
            //         onPressed: () {
            //           box.clear();
            //           cartinit = false;
            //           setState(() {});
            //         },
            //         child: Text('clear'))
            //   ],
            // );
          }),
      // body:  ListView.builder(
      //       itemCount: loadedproduct.cartlistbyid.length,
      //       itemBuilder: (context,index) {
      //         return Column(
      //           children: [
      //             Image.network(
      //               loadedproduct.cartlistbyid[index].image,
      //               width: 100,
      //               height: 100,
      //             ),
      //             Text(loadedproduct.cartlistbyid[index].title),
      //             Text(loadedproduct.cartlistbyid[index].price.toString()),
      //
      //             Row(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   IconButton(
      //                     icon: Icon(Icons.add),
      //                     onPressed: () {
      //                       loadedproduct.updateProduct(loadedproduct.cartlistbyid[index],
      //                           loadedproduct.cartlistbyid[index].qty + 1);
      //                       // model.removeProduct(model.cart[index]);
      //                     },
      //                   ),
      //                   Text(loadedproduct.cartlistbyid[index].qty.toString()),
      //                   IconButton(
      //                     icon: Icon(Icons.remove),
      //                     onPressed: () {
      //                       loadedproduct.updateProduct(loadedproduct.cartlistbyid[index],
      //                               loadedproduct.cartlistbyid[index].qty - 1);
      //                           // model.removeProduct(model.cart[index]);
      //                         },
      //                       ),
      //                     ]),
      //                 ElevatedButton(onPressed: (){
      //                   loadedproduct.removefromcart(loadedproduct.cartlistbyid[index]);
      //                   loadedproduct.cartlistbyid[index].isincart=!loadedproduct.cartlistbyid[index].isincart;
      //                   setState(() {
      //
      //                   });
      //                 }, child: Icon(Icons.remove_circle_outline))
      //               ],
      //             );
      //           }
      //       );
      //
      //
      //
    );
  }
}
