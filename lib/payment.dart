import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:starshmucks/razorpay.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'upi_payment.dart';
import 'boxes.dart';
import 'home_screen.dart';
import 'model/cart_model.dart';
import 'order_success.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

enum Pet { Upi, Razorpay }

class _PaymentPageState extends State<PaymentPage> {
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
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.credit_card,
                size: 50,
                color: HexColor("#175244"),
              ),
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
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              // for (int i = 1; i <= 5; i++)

              RadioListTile(
                value: 1,
                title: Text('UPI'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                activeColor: HexColor("#175244"),
                groupValue: _value,
                contentPadding: EdgeInsets.only(left: 10),
                tileColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    _value = value!;
                  });
                },
              ),
              SizedBox(
                height: 5,
              ),
              RadioListTile(
                value: 2,
                title: Text("RazorPay"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                activeColor: HexColor("#175244"),
                groupValue: _value,
                contentPadding: EdgeInsets.only(left: 10),
                tileColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    _value = value!;
                  });
                },
              ),
            ],
          ),
        )
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
                            'amount': result * 100,
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
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
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
        Get.to(Ordersuccess());
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
