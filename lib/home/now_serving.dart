import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';

import '../productdetail.dart';
import '/db/menu_db.dart';
import '../db/cart_db.dart';
import '../model/cart_model.dart';
import '../model/menu_model.dart';
import 'home_screen.dart';

class NowServing extends StatefulWidget {
  const NowServing({Key? key}) : super(key: key);

  @override
  State<NowServing> createState() => _NowServingState();
}

class _NowServingState extends State<NowServing> {
  late MenuDB db;
  bool getdataf = false;
  List<MenuModel> nowdata = [];
  late var product;

  late CartDB cdb;

  @override
  void initState() {
    cdb = CartDB();
    cdb.initDBCart();
    db = MenuDB();
    db.initDBMenu();

    super.initState();
  }

  addToCart(context, index) async {
    final cartp = await db.NowServedata();
    cdb.insertDataCart(
      CartModel(id: cartp[index].id, qty: 1),
    );
    setState(() {});
  }

  getdata() async {
    nowdata = await db.NowServedata();
    setState(() {
      getdataf = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    getdata();
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
                  getpdata(nowdata[index]);
                  Get.to(ProductDetail(),transition: Transition.downToUp);
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
