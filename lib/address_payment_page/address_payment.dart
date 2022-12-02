import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';

import '/upi_payment.dart';
import '/model/address_model.dart';
import '../common_things.dart';
import '../db/cart_db.dart';
import '../db/orders_db.dart';
import '../db/user_db.dart';
import '../model/cart_model.dart';
import '../order/order_failed.dart';
import '../order/order_success.dart';
import 'common_widgets.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

enum Pet { Upi, Razorpay }

String message = '';
final offers = TextEditingController();

class _AddressState extends State<Address> {
  late UserDB udb;
  late List<Map<String, dynamic?>> addressList = [];
  bool isChecked = false;
  bool paid = false;
  int _value = 1;
  void initState() {
    udb = UserDB();
    udb.initDBUserData();

    super.initState();
  }

  List<Map<String, dynamic>> userddt = [];
  getUser() async {
    userddt = await udb.getDataUserData();
    addressList = await udb.getDataUserAddress1();
    setState(() {});
  }

  deleteAddress(sendingID) {
    udb.deleteitem(sendingID);
    setState(() {});
  }

  addAddress(context) {
    final fname = TextEditingController();
    final phone = TextEditingController();
    final hno = TextEditingController();
    final roadname = TextEditingController();
    final city = TextEditingController();
    final state = TextEditingController();
    final pincode = TextEditingController();

    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Text(
                      "New Address",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#175244"),
                      ),
                    ),
                  ),
                  //full name
                  commonTextIPWidget(context, fname, "Full Name"),
                  //phone number
                  commonPhoneNumberWidget(context, phone),
                  //house no, building name
                  commonTextIPWidget(context, hno, 'House No., Building Name'),
                  //road name,area,colony
                  commonTextIPWidget(
                      context, roadname, 'Road Name, Area, Colony'),
                  //city
                  commonTextIPWidget(context, city, 'City'),
                  //state
                  commonTextIPWidget(context, state, 'State'),
                  //pincode
                  commonTextIPWidget(context, pincode, 'Pincode'),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    // height: 100,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        var addressStore = AddressModel(
                          userID: userddt[0]['id'],
                          fname: fname.text,
                          phone: phone.text,
                          hno: hno.text,
                          road: roadname.text,
                          city: city.text,
                          state: state.text,
                          pincode: pincode.text,
                          // addressID: ,
                        );
                        udb.insertUserAddress(addressStore);
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60)),
                        backgroundColor: HexColor("#036635"),
                      ),
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  editAddress(context, index, addid) {
    final fname = TextEditingController(text: addressList[index]['fname']);
    final phone = TextEditingController(text: addressList[index]['phone']);
    final hno = TextEditingController(text: addressList[index]['hno']);
    final roadname = TextEditingController(text: addressList[index]['road']);
    final city = TextEditingController(text: addressList[index]['city']);
    final state = TextEditingController(text: addressList[index]['state']);
    final pincode = TextEditingController(text: addressList[index]['pincode']);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Text(
                      "Edit Address",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#175244"),
                      ),
                    )),
                //full name
                commonTextIPWidget(context, fname, "Full Name"),
                //phone number
                commonPhoneNumberWidget(context, phone),
                //house no, building name
                commonTextIPWidget(context, hno, 'House No., Building Name'),
                //road name,area,colony
                commonTextIPWidget(
                    context, roadname, 'Road Name, Area, Colony'),
                //city
                commonTextIPWidget(context, city, 'City'),
                //state
                commonTextIPWidget(context, state, 'State'),
                //pincode
                commonTextIPWidget(context, pincode, 'Pincode'),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  // height: 100,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      var addressUpdate = AddressModel(
                        userID: userddt[0]['id'],
                        fname: fname.text,
                        phone: phone.text,
                        hno: hno.text,
                        road: roadname.text,
                        city: city.text,
                        state: state.text,
                        pincode: pincode.text,
                        // addressID: ,
                      );
                      print(index);
                      udb.updateAddress(addid, addressUpdate);
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)),
                      backgroundColor: HexColor("#036635"),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var selectedVal;
  setSelectedVal(var val) {
    print("val in fn");
    print(val);
    setState(() {
      selectedVal = val;
    });
  }

  final offers = TextEditingController();
  bool afterSelecting = false;
  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      appBar: AppBar(
        //  title: Text('Delivery Address'),
        backgroundColor: Colors.white,
        foregroundColor: HexColor("#175244"),
        actions: [
          TextButton(
            onPressed: () {
              addAddress(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Text(
                '+ Add Address',
                style: TextStyle(color: HexColor("#036635")),
              ),
            ),
          ),
        ],
      ),
      body: addressList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No Address'),
                ],
              ),
            )

          //int? len = int?.parse(data[0].address.length! / 7);
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  afterSelecting
                      ? Container()
                      : Center(
                          child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Select a Address",
                                style: TextStyle(color: Colors.red),
                              ))),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontSize: 20,
                        color: HexColor("#175244"),
                      ),
                    ),
                  ),
                  Container(
                    color: HexColor("#eeeeee"),
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 1,
                    padding: EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      //height: 180,
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: addressList.length,
                          itemBuilder: (BuildContext context, int index) {
                            String addressSendToOtherPage = addressList[index]
                                    ['fname'] +
                                "\n" +
                                addressList[index]['hno'] +
                                ", " +
                                addressList[index]['road'] +
                                ", " +
                                addressList[index]['city'] +
                                ", " +
                                addressList[index]['state'] +
                                "." +
                                "\n" +
                                addressList[index]['pincode'];
                            return SizedBox(
                              width: 350,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, top: 15),
                                shadowColor: HexColor("#036635"),
                                elevation: 0,
                                child: Column(
                                  children: [
                                    //radio
                                    RadioListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Text(
                                          addressList[index]['fname'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Address",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black38),
                                          ),
                                          Text(
                                            addressList[index]['hno'] +
                                                ", " +
                                                addressList[index]['road'] +
                                                ", " +
                                                addressList[index]['city'] +
                                                ", " +
                                                addressList[index]['state'] +
                                                ".",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Pincode: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black38),
                                              ),
                                              Text(
                                                addressList[index]['pincode'],
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Phone :",
                                                  style: TextStyle(
                                                    color: Colors.black38,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  addressList[index]['phone'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      value: addressList[index]['addressID'],
                                      groupValue: selectedVal,
                                      onChanged: (value) async {
                                        setState(() {
                                          print("onchange");
                                          // print(value);
                                          print(index);
                                          setSelectedVal(value);
                                          afterSelecting = true;
                                        });
                                        final addressSharedPred =
                                            await SharedPreferences
                                                .getInstance();
                                        await addressSharedPred.setString(
                                            'selectedAddress',
                                            addressSendToOtherPage);
                                      },
                                      selected: selectedVal ==
                                          addressList[index]['addressID'],
                                      activeColor: HexColor("#036635"),

                                      //selectedTileColor: Colors.red,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, top: 10),
                                      child: Divider(
                                        color: Colors.grey,
                                        height: 1,
                                        thickness: 0.2,
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              deleteAddress(addressList[index]
                                                  ['addressID']);
                                              setState(() {});
                                            },
                                            child: Text(
                                              'Delete',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
                                        TextButton(
                                          onPressed: () {
                                            print(addressList[index]
                                                ['addressID']);
                                            editAddress(
                                                context,
                                                index,
                                                addressList[index]
                                                    ['addressID']);
                                          },
                                          child: Text(
                                            'Edit',
                                            style: TextStyle(
                                                color: HexColor("#036635")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(top: 4, left: 15),
                                      child: AutoSizeText(
                                        'Payment Mode',
                                        style: TextStyle(
                                          color: HexColor("#175244"),
                                        ),
                                        minFontSize: 20,
                                        maxFontSize: 30,
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(top: 4, left: 15),
                                      child: AutoSizeText(
                                        'Select your preferred payment mode',
                                        style: TextStyle(
                                          color: HexColor("#38564F"),
                                        ),
                                        minFontSize: 10,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
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
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 20),
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
                              margin: EdgeInsets.only(
                                  bottom: 10, left: 20, right: 20),
                              width: MediaQuery.of(context).size.width * 0.89,
                              child: TextFormField(
                                style: const TextStyle(
                                    color: Colors.black), //<-- SEE HERE
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
                        Container(
                          margin:
                              EdgeInsets.only(top: 10, bottom: 10, left: 20),
                          child: AutoSizeText(
                            'Use Your Rewards',
                            style: TextStyle(
                              color: HexColor("#175244"),
                            ),
                            minFontSize: 20,
                            maxFontSize: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AutoSizeText(
                                        'Available Rewards ',
                                        style: TextStyle(
                                          color: HexColor("#175244"),
                                        ),
                                        minFontSize: 20,
                                        maxFontSize: 30,
                                      ),
                                      AutoSizeText(
                                        "temp rewards",
                                        //data2[0].rewards.toString(),
                                        style: TextStyle(
                                          color: HexColor("#175244"),
                                        ),
                                        minFontSize: 20,
                                        maxFontSize: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white,
                                      fillColor: MaterialStateProperty.all(
                                          HexColor("#175244")),
                                      focusColor: Colors.green,
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          // isChecked = !isChecked;
                                          // final box = Boxes.getCartData();
                                          // final data = box.values.toList().cast<CartData>();
                                          // var res = data[0].ttlPrice - (data2[0].rewards!.toDouble()/10);
                                          // data[0].ttlPrice = res;
                                          // print('reward calc: '+ data[0].ttlPrice.toString());
                                          // box.putAt(0, data[0]);
                                        });
                                      },
                                    ),
                                    AutoSizeText(
                                      'Use my rewards',
                                      minFontSize: 20,
                                      style: TextStyle(
                                        color: HexColor("#175244"),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 150,
            ),
            ElevatedButton(
              onPressed: () {
                if (_value == 1 && afterSelecting == true) {
                  Get.to(UpiPayment());
                } else if (_value == 2 && afterSelecting == true) {
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
                  razorpay.on(
                      Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                      handlePaymentSuccessResponse);
                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                      handleExternalWalletSelected);
                  razorpay.open(options);
                }

                //   afterSelecting
                //       ? Get.to(PaymentPage(), transition: Transition.rightToLeft)
                //       : Container();
              },
              child: Text("Pay"),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(HexColor("#036635"))),
            ),
          ],
        ),
      ),
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
      goToFailed(message);
    });

    // showAlertDialog(context, "Payment Failed",
    //     "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
    message = "${response.message}";
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    putDatafromcart();
    print("sign" + response.orderId.toString());
    setState(() {
      goToSuccess();
      paid = true;
    });

    // showAlertDialog(
    //     context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  List<CartModel> cartlist = [];

  putDatafromcart() async {
    OrdersDB orderdb = OrdersDB();
    CartDB cartdb = CartDB();
    orderdb.initDBOrders();
    cartdb.initDBCart();
    String idar = '';
    String qtyar = '';
    String date = DateFormat.yMMMMd('en_US').format(DateTime.now());
    String time = DateFormat.jm().format(DateTime.now());
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
    orderdb.createarr(idar, qtyar, date, time);
    setState(() {});
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    print("wallet");
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        paid ? Get.to(OrderSuccess()) : Get.to(OrderFail(message));
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
