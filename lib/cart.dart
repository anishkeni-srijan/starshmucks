import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  void initState() {
    super.initState();
  }

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
          child: Row(
            children: [
              Text(
                "Total: ",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 160,
              ),
              ElevatedButton(onPressed: () {}, child: Text("Checkout")),
            ],
          )),
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Text("cart"),
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
