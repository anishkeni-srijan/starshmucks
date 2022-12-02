import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';

import '../address_payment_page/address_payment.dart';
import '../help_page.dart';
import '/common_things.dart';

class OrderFail extends StatefulWidget {
  late String message;
  OrderFail(this.message);

  @override
  State<OrderFail> createState() => _OrderFailState();
}

class _OrderFailState extends State<OrderFail> {
  var result;
  getcarttotal() {}
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
                        )
                    )
                  ],
                ),
              ),
              Column(
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
                          children: [
                            Text(
                              "Payment Failure:",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(failedMessage),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 1,
                    child: Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 20,right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                  child: Text("Cart Total"),
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
                                // Text("\$ " + (result + 5).toString()),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(Help());
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

                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#036635"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Get.to(bottomBar());
                    },
                    child: Text("Continue Shopping")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
