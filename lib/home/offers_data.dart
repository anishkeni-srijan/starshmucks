import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

import '../boxes.dart';
import '../db/cart_db.dart';
import '../db/nowserve_db.dart';
import '../db/offers_db.dart';
import '../model/cartDBModel.dart';
import '../model/cart_model.dart';
import '../model/offers_model.dart';
import '../providers/offers_provider.dart';
import 'home_screen.dart';

class getoffers extends StatefulWidget {
  const getoffers({Key? key}) : super(key: key);

  @override
  State<getoffers> createState() => _getoffersState();
}

class _getoffersState extends State<getoffers> {
  late OffersDb db;
  bool getdataf = false;
  late var product;
  List<Offer> odata = [];
  late CartDB cdb;
  @override
  void initState() {
    cdb = CartDB();
    cdb.initDBCart();
    db = OffersDb();
    db.initOffersdb();
    getdata();
    super.initState();
  }

  getdata() async {
    odata = (await db.Offersdata()).cast<Offer>();
    setState(() {
      getdataf = true;
    });
  }

  addToCart(context, index) async {
    late OffersDb db;
    db = OffersDb();
    final cartp = await db.Offersdata();
    print("in cart " + index.toString());
    final box = Boxes.getCartData();
    final cdata = box.values.toList().cast<CartData>();
    print("Cartpindex");
    print(cartp[index].id);
    cdb.insertDataCart(
      CartModel(id: cartp[index].id),
    );
    // final cartp = Provider.of<OffersData>(context, listen: false);
    final cartItem = CartData()
      ..title = cartp[index].title
      ..price = cartp[index].price
      ..qty = 1
      ..isInCart = true
      ..image = cartp[index].image
      ..ttlPrice = 0.0
      ..id = cartp[index].id;
    int zindex = cdata.indexWhere((item) => item.id == cartp[index].id);
    print("test " + zindex.toString());
    if (zindex != -1) {
      cdata[zindex].qty++;
      box.putAt(zindex, cdata[zindex]);
      print("already inn");
    } else {
      box.add(cartItem);
      print(cartItem.title);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('offerdata len' + odata.length.toString());
    return ValueListenableBuilder<Box<CartData>>(
        valueListenable: Boxes.getCartData().listenable(),
        builder: (context, box, _) {
          bool flag = false;
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: odata.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // getofferdetails(context, index);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? Colors.teal
                              : Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: MediaQuery.of(context).size.height * 0.18,
                        width: MediaQuery.of(context).size.width * 0.76,
                        child: Stack(
                          children: [
                            Container(
                              transform: Matrix4.translationValues(-10, 20, 0),
                              child: Image.asset(
                                odata[index].image,
                                width: 150,
                                height: 150,
                              ),
                            ),
                            Container(
                              child: Container(
                                // transform: Matrix4.translationValues(-120, 10, 0),
                                margin: EdgeInsets.only(
                                  top: 10,
                                  left: 130,
                                ),
                                child: Text(
                                  odata[index].tag,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 30,
                                left: 130,
                              ),
                              child: Text(
                                odata[index].title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Container(
                              // transform: Matrix4.translationValues(-320, 40, 0),
                              margin: EdgeInsets.only(
                                top: 85,
                                left: 190,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  //if (data.isEmpty) {
                                  addToCart(context, index);
                                  setState(() {
                                    cartinit = true;
                                  });
                                },
                                child: flag ? Text('Added') : Text("Add"),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          HexColor('#175244')),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }
}
