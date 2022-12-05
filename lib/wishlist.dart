import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:starshmucks/db/wishlist_db.dart';
import 'package:starshmucks/model/wishlist_model.dart';
import 'address_payment_page/address_payment.dart';
import 'db/cart_db.dart';
import 'db/menu_db.dart';
import 'db/orders_db.dart';
import 'home/home_screen.dart';
import 'model/cart_model.dart';
import 'model/menu_model.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  bool ischecked = false;
  var result;
  @override
  late WishlistDB wdb;
  late MenuDB menudb;
  late OrdersDB orderdb;
  late List<MenuModel> kart = [];
  late List<MenuModel> kart1 = [];
  late List<WishlistModel> datalist = [];
  List<WishlistModel> wishlist = [];
  double ttl = 0;
  @override
  void initState() {
    menudb = MenuDB();
    menudb.initDBMenu();
    wdb = WishlistDB();
    wdb.initDBWishlist();
    super.initState();
  }

  getDataOnIds() async {
    datalist = await wdb.getDataWishlist();
    for (var i = 0; i < datalist.length; i++) {
      kart = await menudb.getElementOnId_Menu(datalist[i].id);
      // print("init cart " + kart.length.toString());
      if (kart.length == 1) kart1.add(kart.first);
    }
    setState(() {});
  }

  removefromcart(sendid) {
    wdb.deleteitemFromWishlist(sendid);
    datalist.isEmpty ? cartinit = false : cartinit = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: datalist == null
          ? const CircularProgressIndicator()
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    elevation: 4,
                    //toolbarHeight: 120,
                    backgroundColor: Colors.white,
                    foregroundColor: HexColor("#175244"),
                    title: Text('Wishlist'),
                  ),
                ];
              },
              body: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: datalist.length,
                      itemBuilder: (context, index) {
                        //print("qty= " + idlist[index].qty.toString());
                        return Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      kart1[index].image,
                                      height: 100,
                                      width: 100,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: 150,
                                              child: Text(kart1[index].title,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                          Text(
                                            "\$ " + kart1[index].price,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              removefromcart(datalist[index]);
                                              print("removing: " +
                                                  index.toString());
                                              setState(() {});
                                            },
                                            style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                        HexColor("#036635"))),
                                            child: const Text(
                                              'Remove',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: () {
                                                // if (datalist[index].qty == 1) {
                                                //   removefromcart(
                                                //       datalist[index]);
                                                // } else {
                                                //   double res1 = (double.parse(
                                                //       kart1[index].price *
                                                //           datalist[index].qty));
                                                //   decreaseqty(
                                                //       datalist[index], res1);
                                                // }
                                                // setState(() {});
                                              },
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                          HexColor("#036635"))),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: () {
                                                // double res = (double.parse(
                                                //     kart1[index].price *
                                                //         datalist[index].qty));
                                                // increaseqty(
                                                //     datalist[index], res);
                                                // setState(() {});
                                              },
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                          HexColor("#036635"))),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
    ;
  }
}
