import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

import '../boxes.dart';
import '../db/cart_db.dart';
import '../db/nowserve_db.dart';
import '../model/cartDBModel.dart';

import '../model/nowserving_model.dart';
import '../providers/nowserving_provider.dart';
import 'home_screen.dart';

class nowserving extends StatefulWidget {
  const nowserving({Key? key}) : super(key: key);

  @override
  State<nowserving> createState() => _nowservingState();
}

class _nowservingState extends State<nowserving> {
  addToCart(context, index) async {
    late NowServeDb db;
    db = NowServeDb();
    final cartp = await db.NowServedata();
    cdb.insertDataCart(
      CartModel(id: cartp[index].id),
    );

    // int zindex = cdata.indexWhere((item) => item.id == cartp[index].id);
    // print("test " + zindex.toString());
    // if (zindex != -1) {
    //   cdata[zindex].qty++;
    //   box.putAt(zindex, cdata[zindex]);
    //   print("already inn");
    // } else {
    //   box.add(cartItem);
    //   print(cartItem.title);
    // }
  }

  late NowServeDb db;
  bool getdataf = false;
  List<NowServe> nowdata = [];
  late var product;

  late CartDB cdb;
  @override
  void initState() {
    cdb = CartDB();
    cdb.initDBCart();
    db = NowServeDb();
    db.initNowServedb();
    getdata();
    super.initState();
  }

  getdata() async {
    nowdata = await db.NowServedata();
    setState(() {
      getdataf = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('nowdata len' + nowdata.length.toString());
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.18,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: nowdata.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  //getnowservedetails(context, index);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        index % 2 == 0 ? Colors.deepOrangeAccent : Colors.teal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width * 0.76,
                  child: Stack(
                    children: [
                      Container(
                        transform: Matrix4.translationValues(-10, 20, 0),
                        child: Image.asset(
                          nowdata[index].image,
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
                            nowdata[index].title,
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
                          nowdata[index].tag,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
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
                            //   final box = Boxes.getCartData();
                            //   final data = box.values.toList().cast<CartData>();

                            // if (data.contains(data[index])) {
                            //   //update qty
                            //   print('imhere');
                            //   return null;
                            // } else
                            //   addToCart(context, index);
                            addToCart(context, index);
                            setState(() {
                              cartinit = true;
                            });
                          },
                          child: Text('Add'),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            foregroundColor: MaterialStateProperty.all<Color>(
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
  }
}
