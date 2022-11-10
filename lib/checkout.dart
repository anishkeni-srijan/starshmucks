import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:starshmucks/user_profile.dart';

import 'Payment.dart';
import 'boxes.dart';
import 'model/cart_model.dart';
import 'model/user_model.dart';

final fname = TextEditingController();
final phone = TextEditingController();
final hno = TextEditingController();
final roadname = TextEditingController();
final city = TextEditingController();
final state = TextEditingController();
final pincode = TextEditingController();
late final List address = [];

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
  var userkey = 0;
  void initState() {
    getuserkey();
    super.initState();
  }

  addAddress(context) {
    final box = Boxes.getUserData();
    final data = box.values.toList().cast<UserData>();

    PhoneNumber number = PhoneNumber(isoCode: 'IN');
    return showModalBottomSheet(
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
                      "New Address",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#175244"),
                      ),
                    )),
                //full name
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: fname,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Full Name',
                      labelStyle: TextStyle(
                        color: HexColor("#175244"),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                //phone number
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 80,
                  child: InternationalPhoneNumberInput(
                    selectorConfig: SelectorConfig(
                        trailingSpace: false,
                        selectorType: PhoneInputSelectorType.DROPDOWN),
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: TextStyle(color: HexColor("#175244")),
                    initialValue: number,
                    textFieldController: phone,
                    inputDecoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(
                        color: HexColor("#175244"),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onInputChanged: (PhoneNumber value) {},
                  ),
                ),
                //house no, building name
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: hno,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'House No., Building Name',
                      labelStyle: TextStyle(
                        color: HexColor("#175244"),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                //road name,area,colony
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: roadname,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Road Name, Area, Colony',
                      labelStyle: TextStyle(
                        color: HexColor("#175244"),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                //city
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: city,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'City',
                      labelStyle: TextStyle(
                        color: HexColor("#175244"),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                //state
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: state,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'State',
                      labelStyle: TextStyle(
                        color: HexColor("#175244"),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                //pincode
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: pincode,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Pincode',
                      labelStyle: TextStyle(
                        color: HexColor("#175244"),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  // height: 100,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      address.add(fname.text);
                      address.add(phone.text);
                      address.add(hno.text);
                      address.add(roadname.text);
                      address.add(city.text);
                      address.add(state.text);
                      address.add(pincode.text);
                      data[userkey].address = address;
                      box.put(userkey, data[userkey]);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)),
                      backgroundColor: HexColor("#036635"),
                    ),
                    child: Text(
                      'SIGN UP',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
        backgroundColor: Colors.white,
        foregroundColor: HexColor("#175244"),
      ),
      body: ValueListenableBuilder<Box<UserData>>(
          valueListenable: Boxes.getUserData().listenable(),
          builder: (context, box, _) {
            final data = box.values.toList().cast<UserData>();
            if (data[userkey].address.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No saved address'),
                    Container(
                      //height: MediaQuery.of(context).size.height * 0.80,
                      child: TextButton(
                          onPressed: () {
                            addAddress(context);
                          },
                          child: Text('Add a new address')),
                    )
                  ],
                ),
              );
            } else {
              //int? len = int?.parse(data[0].address.length! / 7);
              return ListView.builder(
                itemCount: data[0].address.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 350,
                            child: Text(
                              data[0].address[index],
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            addAddress(context);
                          },
                          child: Text('Add a new address')),
                    ],
                  );
                },
              );
            }
          }),
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
                        Get.to(PaymentPage(),
                            transition: Transition.rightToLeft);
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
}
