import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';

import '../common_things.dart';
import '../db/wishlist_db.dart';
import '../home/home_screen.dart';
import '../model/cart_model.dart';
import '../model/menu_model.dart';
import '../model/wishlist_model.dart';
import '../productdetail.dart';
import '/db/cart_db.dart';
import '/db/menu_db.dart';

class GetCoffeeData extends StatefulWidget {
  const GetCoffeeData({Key? key}) : super(key: key);

  @override
  State<GetCoffeeData> createState() => _GetCoffeeDataState();
}

class _GetCoffeeDataState extends State<GetCoffeeData> {
  late MenuDB menuDB;
  bool getdataf = false;
  List<MenuModel> data = [];

  late CartDB cdb;
  late WishlistDB wdb;
  late MenuDB db;
  late FToast fToast;
  @override
  void initState() {
    cdb = CartDB();
    cdb.initDBCart();
    getCartData1();
    menuDB = MenuDB();
    menuDB.initDBMenu();
    getCoffeeData();
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
    print("ids");
    print(ids);
  }

  removefromwishlist(sendid) {
    wdb.deleteitemFromWishlist(sendid);
    getIds();
  }

  addToWishlist(context, index) async {
    final cartp = await menuDB.coffeedata();
    wdb.insertDataWishlist(WishlistModel(id: cartp[index].id));
    getIds();
  }

  addToCartCoffee(context, index) async {
    final cartp = await menuDB.coffeedata();
    cdb.insertDataCart(CartModel(id: cartp[index].id, qty: 1));
    setState(() {});
  }

  List<CartModel> cartData = [];
  getCartData1() async {
    cartData = await cdb.getDataCart();
    setState(() {});
  }

  getCoffeeData() async {
    data = await menuDB.coffeedata();
    if (this.mounted) {
      setState(() {
        getdataf = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initcart();
    getCoffeeData();
    return Scaffold(
      persistentFooterButtons: cartinit ? [viewincart()] : null,
      body: getdataf
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                bool status = false;
                for (var i = 0; i < ids.length; i++) {
                  if (ids[i] == data[index].id) status = true;
                }
                return GestureDetector(
                  onTap: () {
                    getpdata(data[index]);
                    Get.to(ProductDetail(), transition: Transition.downToUp);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              color: HexColor("#175244"), width: 0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start, //change here don't //worked
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10, bottom: 20),
                          transform: Matrix4.translationValues(-10, 20, 0),
                          child: Image.asset(
                            data[index].image,
                            width: 150,
                            height: 150,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AutoSizeText(
                                data[index].title,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                maxFontSize: 18,
                                maxLines: 1,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                              Text(
                                " \$ " + data[index].price,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.06,
                              ),
                              Row(
                                children: <Widget>[
                                  AutoSizeText(
                                    data[index].rating,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    minFontSize: 12,
                                    maxFontSize: 18,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.amberAccent,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.22),
                                    child: TextButton(
                                      onPressed: () {
                                        addToCartCoffee(context, index);
                                        String toastMessage =
                                            "ITEM ADDED TO CART";
                                        fToast.showToast(
                                          child: CustomToast(toastMessage),
                                          positionedToastBuilder:
                                              (context, child) => Positioned(
                                            child: child,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.14,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                          ),
                                        );
                                        setState(() {
                                          cartinit = true;
                                        });
                                      },
                                      child: Text('Add'),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                index % 2 == 0
                                                    ? Colors.teal
                                                    : Colors.deepOrangeAccent),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        //int id = odata[index].id;
                                        status
                                            ? removefromwishlist(WishlistModel(
                                                id: data[index].id))
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : CircularProgressIndicator(),
    );
  }
}
