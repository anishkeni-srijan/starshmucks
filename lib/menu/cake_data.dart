import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
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

class GetCakeData extends StatefulWidget {
  const GetCakeData({Key? key}) : super(key: key);

  @override
  State<GetCakeData> createState() => _GetCakeDataState();
}

class _GetCakeDataState extends State<GetCakeData> {
  late MenuDB db;
  bool getdataf = false;
  List<MenuModel> data = [];

  late CartDB cdb;
  late WishlistDB wdb;
  @override
  void initState() {
    cdb = CartDB();
    cdb.initDBCart();

    db = MenuDB();
    db.initDBMenu();
    getdata();
    wdb = WishlistDB();
    wdb.initDBWishlist();
    super.initState();
  }

  addToWishlist(context, index) async {
    final cartp = await db.cakedata();
    wdb.insertDataWishlist(WishlistModel(id: cartp[index].id));
    // setState(() {});
  }

  addToCart(context, index) async {
    final cartp = await db.cakedata();
    var ttl = await cdb.getDataCart();
    ttl.isEmpty
        ? cdb.insertDataCart(CartModel(id: cartp[index].id, qty: 1))
        : cdb.insertDataCart(CartModel(
            id: cartp[index].id,
            qty: 1,
          ));

    // setState(() {});
  }

  getdata() async {
    data = await db.cakedata();
    setState(() {
      getdataf = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    initcart();
    return Scaffold(
        persistentFooterButtons: cartinit ? [viewincart()] : null,
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
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
                      bottom:
                          BorderSide(color: HexColor("#175244"), width: 0.2)),
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
                            height: MediaQuery.of(context).size.width * 0.03,
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
                            height: MediaQuery.of(context).size.width * 0.06,
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
                                    left: MediaQuery.of(context).size.width *
                                        0.22),
                                child: TextButton(
                                  onPressed: () {
                                    addToCart(context, data[index].id);

                                    setState(
                                      () {
                                        cartinit = true;
                                      },
                                    );
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
                                    addToWishlist(context, index);
                                  },
                                  icon: Icon(Icons.favorite_border))
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
        ));
  }
}
