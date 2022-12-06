import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io' show Platform;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:starshmucks/common_things.dart';
import 'package:starshmucks/model/wishlist_model.dart';
import 'package:starshmucks/productdetail.dart';
import '../db/cart_db.dart';
import '../db/menu_db.dart';
import '../db/wishlist_db.dart';
import '../model/cart_model.dart';
import '../model/menu_model.dart';
import 'home_screen.dart';

class GetOffers extends StatefulWidget {
  const GetOffers({Key? key}) : super(key: key);

  @override
  State<GetOffers> createState() => _GetOffersState();
}

class _GetOffersState extends State<GetOffers> {
  late MenuDB db;
  bool getdataf = false;
  List<MenuModel> odata = [];
  late var product;
  late FToast fToast;
  late CartDB cdb;
  late WishlistDB wdb;
  bool wlistStatus = false;
  @override
  void initState() {
    cdb = CartDB();
    cdb.initDBCart();
    db = MenuDB();
    db.initDBMenu();
    wdb = WishlistDB();
    wdb.initDBWishlist();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  getdata() async {
    odata = await db.Offersdata();
    getdataf = true;
  }

  addToCart(context, index) async {
    final cartp = await db.Offersdata();
    // List<CartModel> ttl = await cdb.getDataCart();
    cdb.insertDataCart(CartModel(id: cartp[index].id, qty: 1));
    setState(() {});
  }

  addToWishlist(context, index) async {
    final cartp = await db.Offersdata();
    wdb.insertDataWishlist(WishlistModel(id: cartp[index].id));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getdata();
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
                  getpdata(odata[index]);
                  Get.to(ProductDetail(),
                      transition: Transition.rightToLeftWithFade);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        index % 2 == 0 ? Colors.teal : Colors.deepOrangeAccent,
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
                            top: Platform.isIOS ? 0 : 10,
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
                          top: Platform.isIOS ? 40 : 30,
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
                            String toastMessage = "ADDED TO CART";
                            fToast.showToast(
                              child: CustomToast(toastMessage),
                              positionedToastBuilder: (context, child) =>
                                  Positioned(
                                child: child,
                                bottom: 120,
                                left: 120,
                              ),
                            );
                            setState(() {
                              cartinit = true;
                            });
                          },
                          child: Text("Add"),
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
                      ),
                      IconButton(
                          onPressed: () {
                            addToWishlist(context, index);
                          },
                          icon: Icon(Icons.favorite_border))
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
