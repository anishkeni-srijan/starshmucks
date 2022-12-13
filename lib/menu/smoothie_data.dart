import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '/db/cart_db.dart';
import '/db/menu_db.dart';
import '../common_things.dart';
import '../db/wishlist_db.dart';
import '../home/home_screen.dart';
import '../model/cart_model.dart';
import '../model/menu_model.dart';
import '../model/wishlist_model.dart';
import '../productdetail.dart';

class GetSmoothieData extends StatefulWidget {
  const GetSmoothieData(context, {Key? key}) : super(key: key);

  @override
  State<GetSmoothieData> createState() => _GetSmoothieDataState();
}

class _GetSmoothieDataState extends State<GetSmoothieData> {
  late MenuDB db;
  bool getdataf = false;
  List<MenuModel> data = [];
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

  addToCartSmoothie(context, index) async {
    final cartp = await db.smoothiedata();
    cdb.insertDataCart(CartModel(id: cartp[index].id, qty: 1));
    // setState(() {});
  }

  getSmoothieData() async {
    data = await db.smoothiedata();
    if (this.mounted) {
      setState(() {
        getdataf = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initcart();
    getSmoothieData();
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
                    Get.to(() => const ProductDetail(),
                        transition: Transition.downToUp);
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, bottom: 20),
                          transform: Matrix4.translationValues(-10, 20, 0),
                          child: Image.asset(
                            data[index].image,
                            width: 150,
                            height: 150,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AutoSizeText(
                                data[index].title,
                                style: const TextStyle(
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
                                style: const TextStyle(
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
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    minFontSize: 12,
                                    maxFontSize: 18,
                                  ),
                                  const Icon(
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
                                        addToCartSmoothie(context, index);
                                        String toastMessage =
                                            "ITEM ADDED TO CART";
                                        fToast.showToast(
                                          child: CustomToast(toastMessage),
                                          positionedToastBuilder:
                                              (context, child) => Positioned(
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
                                            child: child,
                                          ),
                                        );
                                        setState(() {
                                          cartinit = true;
                                        });
                                      },
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
                                      child: const Text('Add'),
                                    ),
                                  ),
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
          : const CircularProgressIndicator(),
    );
  }
}
