import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:starshmucks/common_things.dart';
import 'package:starshmucks/home_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

import 'boxes.dart';
import 'model/cart_model.dart';

class Ordersuccess extends StatefulWidget {
  Ordersuccess({Key? key}) : super(key: key);

  @override
  _OrdersuccessState createState() => _OrdersuccessState();
}

class _OrdersuccessState extends State<Ordersuccess> {
  @override
  void initState() {
    getAddress();
    super.initState();
    cartinit = false;
  }

  late String selectedAddress = '';
  getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedAddress = prefs.getString("selectedAddress")!;
    setState(() {});
    print("test " + selectedAddress);
    return selectedAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              TextButton.icon(
                icon: Icon(Icons.arrow_back),
                label: Text(''),
                onPressed: () {
                  Get.to(bottomBar());
                },
              ),
              Text(
                "Order details",
                style: TextStyle(color: HexColor("#175244")),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          foregroundColor: HexColor("#175244"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                        'Order Placed!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    Container(
                        transform: Matrix4.translationValues(0, 40, 0),
                        child: AutoSizeText(
                          'Your order will take 30-35mins',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
              ValueListenableBuilder<Box<CartData>>(
                  valueListenable: Boxes.getCartData().listenable(),
                  builder: (context, box, _) {
                    final data = box.values.toList().cast<CartData>();
                    if (data.isEmpty) {
                      cartinit = false;
                    }
                    return data.isEmpty
                        ? Center(child: Text("No items in cart"))
                        : SizedBox(
                            width: 400,
                            height: 400,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          data[index].image,
                                          height: 100,
                                          width: 100,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: 150,
                                                  child: Text(data[index].title,
                                                      maxLines: 2,
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                              Text(data[index].qty.toString() +
                                                  ' x qty'),
                                            ],
                                          ),
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(children: [
                                                AutoSizeText(
                                                  "\$ " + data[index].price,
                                                  minFontSize: 20,
                                                ),
                                              ]),
                                            ])
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(
                                        color: HexColor("#036635"),
                                        height: 1,
                                        thickness: 0.5,
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                  }),
              Container(
                child: Text("Delivering to:\n" + selectedAddress.toString()),
              )
            ],
          ),
        ));
  }
}
