import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';

import '../common_things.dart';
import '../db/wishlist_db.dart';
import '../model/wishlist_model.dart';
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
  late WishlistDB wdb;
  late FToast fToast;
  @override
  void initState() {
    cdb = CartDB();
    cdb.initDBCart();
    db = MenuDB();
    db.initDBMenu();
    wdb = WishlistDB();
    wdb.initDBWishlist();
    getIds();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  late List<int> ids = [];
  getIds() async {
    ids.clear();
    late List<WishlistModel> datalist = [];
    datalist = await wdb.getDataWishlist();
    for (var i = 0; i < datalist.length; i++) {
      ids.add(datalist[i].id);
    }
    setState(() {});
  }

  removefromwishlist(sendid) {
    wdb.deleteitemFromWishlist(sendid);
    String toastMessage = "ITEM REMOVED TO WISHLIST";
    fToast.showToast(
      child: CustomToast(toastMessage),
      positionedToastBuilder: (context, child) => Positioned(
        child: child,
        bottom: MediaQuery.of(context).size.height * 0.14,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
      ),
    );
    getIds();
  }

  addToCart(context, index) async {
    final cartp = await db.NowServedata();
    var ttl = await cdb.getDataCart();
    cdb.insertDataCart(CartModel(id: cartp[index].id, qty: 1));

    setState(() {});
  }

  addToWishlist(context, index) async {
    final cartp = await db.NowServedata();
    wdb.insertDataWishlist(WishlistModel(id: cartp[index].id));
    String toastMessage = "ITEM ADDED TO WISHLIST";
    fToast.showToast(
      child: CustomToast(toastMessage),
      positionedToastBuilder: (context, child) => Positioned(
        child: child,
        bottom: MediaQuery.of(context).size.height * 0.14,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
      ),
    );
    getIds();
    // setState(() {});
  }

  getdata() async {
    nowdata = await db.NowServedata();
    getdataf = true;
    setState(() {});
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
          bool status = false;
          for (var i = 0; i < ids.length; i++) {
            if (ids[i] == nowdata[index].id) status = true;
          }
          return Row(
            children: [
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  getpdata(nowdata[index]);
                  Get.to(ProductDetail(), transition: Transition.downToUp);
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
                            String toastMessage = "ITEM ADDED TO CART";
                            fToast.showToast(
                              child: CustomToast(toastMessage),
                              positionedToastBuilder: (context, child) =>
                                  Positioned(
                                child: child,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.14,
                                left: MediaQuery.of(context).size.width * 0.1,
                                right: MediaQuery.of(context).size.width * 0.1,
                              ),
                            );
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
                      ),
                      IconButton(
                          onPressed: () {
                            //int id = odata[index].id;
                            status
                                ? removefromwishlist(
                                    WishlistModel(id: nowdata[index].id))
                                : addToWishlist(context, index);
                            // getIds();
                          },
                          icon: status
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(Icons.favorite_border))
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
