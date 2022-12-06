import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '/db/wishlist_db.dart';
import '/model/wishlist_model.dart';
import 'db/menu_db.dart';
import 'db/orders_db.dart';
import 'home/home_screen.dart';

import 'model/menu_model.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  bool ischecked = false;

  @override
  late WishlistDB wdb;
  late MenuDB menudb;
  late List<MenuModel> kart = [];
  //late List<MenuModel> kart1 = [];
  late List<WishlistModel> datalist = [];
  List<WishlistModel> wishlist = [];
  //double ttl = 0;
  @override
  void initState() {
    menudb = MenuDB();
    menudb.initDBMenu();
    wdb = WishlistDB();
    wdb.initDBWishlist();
    getDataOnIds();
    super.initState();
  }

  getDataOnIds() async {
    datalist = await wdb.getDataWishlist();
    List<MenuModel> wishlistTmp = [];
    for (var i = 0; i < datalist.length; i++) {
      var wdata = await menudb.getElementOnId_Menu(datalist[i].id);
      // print("init cart " + kart.length.toString());
      if (wdata.length == 1) {
        //tempTotal += (double.parse(wdata.first.price) * datalist[i].qty);
        wishlistTmp.add(wdata.first);
      }
    }
    kart = wishlistTmp;
    setState(() {});
  }

  removefromwishlist(sendid) {
    wdb.deleteitemFromWishlist(sendid);
    // datalist.isEmpty ? cartinit = false : cartinit = true;
    getDataOnIds();
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getDataOnIds();
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
                        return Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      kart[index].image,
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
                                              child: Text(kart[index].title,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                          Text(
                                            "\$ " + kart[index].price,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              removefromwishlist(
                                                  datalist[index]);
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
