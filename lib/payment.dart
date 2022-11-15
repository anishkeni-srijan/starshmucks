import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'order_failed.dart';
import 'upi_payment.dart';
import 'boxes.dart';
import 'model/cart_model.dart';
import 'order_success.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

enum Pet { Upi, Razorpay }

String message = '';
final offers = TextEditingController();

class _PaymentPageState extends State<PaymentPage> {
  bool paid = false;
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    Pet _pet = Pet.Upi;
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.white,
        foregroundColor: HexColor("#175244"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 4, left: 0),
                      child: AutoSizeText(
                        'Payment Mode',
                        style: TextStyle(
                          color: HexColor("#175244"),
                        ),
                        minFontSize: 20,
                        maxFontSize: 30,
                      )),
                  Container(
                      transform: Matrix4.translationValues(15, 2, 0),
                      child: AutoSizeText(
                        'Select your prefered payment mode',
                        style: TextStyle(
                          color: HexColor("#38564F"),
                        ),
                        minFontSize: 8,
                        maxFontSize: 10,
                      ))
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              RadioListTile(
                value: 1,
                title: Text('UPI'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                activeColor: HexColor("#175244"),
                groupValue: _value,
                contentPadding: EdgeInsets.only(left: 10),
                tileColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    _value = value!;
                  });
                },
              ),
              Divider(
                color: HexColor("#175244"),
                height: 1,
                thickness: 0.6,
                indent: 10,
                endIndent: 10,
              ),
              RadioListTile(
                value: 2,
                title: Text("RazorPay"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                activeColor: HexColor("#175244"),
                groupValue: _value,
                contentPadding: EdgeInsets.only(left: 10),
                tileColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    _value = value!;
                  });
                },
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20),
              child: AutoSizeText(
                'Offers & benefits',
                style: TextStyle(
                  color: HexColor("#175244"),
                ),
                minFontSize: 20,
                maxFontSize: 30,
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
              width: MediaQuery.of(context).size.width * 0.89,
              child: TextFormField(
                style: const TextStyle(color: Colors.black), //<-- SEE HERE
                controller: offers,
                onChanged: (value) {},
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  labelText: 'Apply Coupon',
                  labelStyle: TextStyle(
                    color: HexColor("#175244"),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: HexColor("#175244"),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: HexColor("#175244"),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
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
                  children: [
                    Text(
                      "Total: \$" + result.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_value == 1) {
                          Get.to(UpiPayment());
                        } else {
                          Razorpay razorpay = Razorpay();
                          var options = {
                            'key': 'rzp_test_jrCnK1rxXepbtl',
                            'amount': 100,
                            'name': 'Starschmucks.',
                            'description': 'Fine Coffee',
                            'retry': {'enabled': true, 'max_count': 1},
                            'send_sms_hash': true,
                            'prefill': {
                              'contact': '8888888888',
                              'email': 'test@razorpay.com'
                            },
                            'external': {
                              'wallets': ['paytm']
                            }
                          };
                          razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                              handlePaymentErrorResponse);
                          razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                              handlePaymentSuccessResponse);
                          razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                              handleExternalWalletSelected);
                          razorpay.open(options);
                        }
                      },
                      child: Text("Pay"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(HexColor("#036635"))),
                    ),
                  ],
                );
              })),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    setState(() {
      paid = false;
    });
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
    message = "${response.message}";
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    setState(() {
      paid = true;
    });
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        paid ? Get.to(Ordersuccess()) : Get.to(OrderFail(message));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

getMessage() {
  return message;
}
