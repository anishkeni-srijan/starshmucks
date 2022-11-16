import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:starshmucks/common_things.dart';

import 'boxes.dart';
import 'home_screen.dart';
import 'model/cart_model.dart';
import 'payment.dart';

class OrderFail extends StatefulWidget {
  late String message;
  OrderFail(this.message);

  @override
  State<OrderFail> createState() => _OrderFailState();
}

class _OrderFailState extends State<OrderFail> {
  var result;
  getcarttotal() {
    final box = Boxes.getCartData();
    final data = box.values.toList().cast<CartData>();
    late double result = 0;
    for (var index = 0; index < data.length; index++) {
      result = result + double.parse(data[index].price) * data[index].qty;
    }
    setState(() {});
    return result;
  }

  String failedMessage = getMessage();
  @override
  void initState() {
    result = getcarttotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: gohome,
      child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                TextButton.icon(
                  icon: Icon(
                    Icons.arrow_back,
                    color: HexColor("#036635"),
                  ),
                  label: Text(''),
                  onPressed: () {
                    Get.to(bottomBar());
                  },
                ),
                Text(
                  "Order Details",
                  style: TextStyle(color: HexColor("#175244")),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            foregroundColor: HexColor("#175244"),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          'Order Failed!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ),
                      Container(
                          transform: Matrix4.translationValues(0, 40, 0),
                          child: AutoSizeText(
                            'Any amount if debited will get refunded within 4-7 days',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Payment Failure:",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(failedMessage),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Order Details",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text("Bag Total"),
                          ),
                          Text("\$ " + result.toString()),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text("Delivery Charges"),
                          ),
                          Text("\$ 5.00"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Total Amount",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text("\$ " + (result + 5).toString()),
                        ],
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#036635"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Get.to(bottomBar());
                    },
                    child: Text("Continue Shopping"))
              ],
            ),
          )),
    );
  }
}
