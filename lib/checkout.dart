import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'Payment.dart';
import 'boxes.dart';
import 'model/cart_model.dart';
import 'model/user_model.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  getuserkey() async {
    final keypref = await SharedPreferences.getInstance();
    userkey = keypref.getInt('userkey')!;
    setState(() {});
    print(userkey);
    return userkey;
  }

  @override
  var userkey;
  void initState() {
    getuserkey();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Address'),backgroundColor: Colors.white,
        foregroundColor: HexColor("#175244"),),
      body: ValueListenableBuilder<Box<UserData>>(
        valueListenable: Boxes.getUserData().listenable(),
    builder: (context, box, _) {
      final data = box.values.toList().cast<UserData>();
      if (data[userkey].address==null) {
        return Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text('No saved address'),
            Container(child: TextButton(onPressed: (){},child: Text('Add a new address')),)
          ],
        ),);
      }
      else{
        return Column(
          children: [
            ListView.builder(
              itemCount: data[0].address?.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(child: Text(data[0].address?[index]),),
                    Container(child: TextButton(onPressed: (){},child: Text('Edit')),)
                  ],
                );

            },),
            Container(child: TextButton(onPressed: (){},child: Text('Add a new address')),)
          ],
        );
      }

    }
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.all(8.0),
          child: ValueListenableBuilder<Box<CartData>>(
              valueListenable: Boxes.getCartData().listenable(),
              builder: (context, box, _) {
                final data = box.values.toList().cast<CartData>();
                late double result = 0;
                for (int index = 0; index < data.length; index++) {
                  result = result + double.parse(data[index].price) * data[index].qty;
                }
                return Row(
                  children: [
                    Text(
                      "Total: \$" + result.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    ElevatedButton(onPressed: () { Get.to(PaymentPage(),transition: Transition.rightToLeft);}, child: Text("Pay") , style: ButtonStyle(backgroundColor: MaterialStateProperty.all(HexColor("#036635"))),),
                  ],
                );
              })),
    );
  }
}
