import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '/model/address_model.dart';
import 'db/user_db.dart';
import 'payment.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  late UserDB udb;
  late List<Map<String, dynamic?>> addressList = [];
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

  @override
  addAddress(context) {
    final fname = TextEditingController();
    final phone = TextEditingController();
    final hno = TextEditingController();
    final roadname = TextEditingController();
    final city = TextEditingController();
    final state = TextEditingController();
    final pincode = TextEditingController();

    PhoneNumber number = PhoneNumber(isoCode: 'IN');
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
                      )),
                  //full name
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005,
                    ),
                    child: TextFormField(
                      style:
                          const TextStyle(color: Colors.black), //<-- SEE HERE
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
                      style:
                          const TextStyle(color: Colors.black), //<-- SEE HERE
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
                      style:
                          const TextStyle(color: Colors.black), //<-- SEE HERE
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
                      style:
                          const TextStyle(color: Colors.black), //<-- SEE HERE
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
                      style:
                          const TextStyle(color: Colors.black), //<-- SEE HERE
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
                      style:
                          const TextStyle(color: Colors.black), //<-- SEE HERE
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
    final phone = TextEditingController(text: "temp");
    final hno = TextEditingController(text: addressList[index]['hno']);
    final roadname = TextEditingController(text: addressList[index]['road']);
    final city = TextEditingController(text: addressList[index]['city']);
    final state = TextEditingController(text: addressList[index]['state']);
    final pincode = TextEditingController(text: addressList[index]['pincode']);

    PhoneNumber number = PhoneNumber(isoCode: 'IN');
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
          : Column(
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
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
                Expanded(

                  // height: 200,
                  child: ListView.builder(
                      itemCount: addressList.length,
                       // scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
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
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin:
                              EdgeInsets.only(left: 20, right: 20, top: 15),
                          shadowColor: HexColor("#036635"),
                          elevation: 4,
                          child: Column(
                            children: [
                              //radio
                              RadioListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 5),
                                  child: Text(
                                    addressSendToOtherPage,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 8),
                                  child: Text(
                                    "Phone : 98765678temp",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
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
                                      await SharedPreferences.getInstance();
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
                                padding: EdgeInsets.only(left: 8, right: 8),
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
                                        style: TextStyle(color: Colors.red),
                                      )),
                                  TextButton(
                                    onPressed: () {
                                      print(
                                          addressList[index]['addressID']);
                                      editAddress(context, index,
                                          addressList[index]['addressID']);
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
                        );
                      }),
                ),
              ],
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(8.0),
        child:
            // ValueListenableBuilder<Box<CartData>>(
            //     valueListenable: Boxes.getCartData().listenable(),
            //     builder: (context, box, _) {
            //       final data = box.values.toList().cast<CartData>();
            Row(
          children: [
            SizedBox(
              width: 150,
            ),
            ElevatedButton(
              onPressed: () {
                afterSelecting
                    ? Get.to(PaymentPage(), transition: Transition.rightToLeft)
                    : Container();
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
}
