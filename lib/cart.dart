import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:starshmucks/home/home_screen.dart';

import '/db/cart_db.dart';
import '/model/cart_model.dart';
import 'address_payment_page/address_payment.dart';
import 'db/menu_db.dart';
import 'db/orders_db.dart';
import 'model/menu_model.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);
  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  bool ischecked = false;
  var result;
  @override
  late CartDB cartdb;
  late MenuDB menudb;
  late OrdersDB orderdb;
  late List<MenuModel> kart = [];
  late List<MenuModel> kart1 = [];
  late List<CartModel> datalist = [];
  late List<CartModel> qtylist = [];
  List<CartModel> cartlist = [];
  double ttl = 0;
  @override
  clearcart() {
    cartdb.clear();
    setState(() {});
  }

  void initState() {
    menudb = MenuDB();
    menudb.initDBMenu();
    cartdb = CartDB();
    cartdb.initDBCart();
    super.initState();
  }

  getDataOnIds() async {
    datalist = await cartdb.getDataCart();
    for (var i = 0; i < datalist.length; i++) {
      kart = await menudb.getElementOnId_Menu(datalist[i].id);
      // print("init cart " + kart.length.toString());
      if (kart.length == 1) kart1.add(kart.first);
    }
    setState(() {});
  }

  removefromcart(sendid) {
    cartdb.deleteitem(sendid);
    datalist.isEmpty ? cartinit = false : cartinit = true;
    setState(() {});
  }

  increaseqty(sendid) {
    cartdb.increseqty(sendid);
    setState(() {});
  }

  decreaseqty(sendid) {
    cartdb.decreaseqty(sendid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getDataOnIds();

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {});
            Get.to(Address(), transition: Transition.rightToLeft);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(HexColor("#036635"))),
          child: const Text("Checkout"),
          //   ),
          // ],
        ),
      ),
      persistentFooterButtons: [
        Container(
          alignment: AlignmentDirectional.centerStart,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 35,
                        color: HexColor("#175244"),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "\$" + ttl.toString(),
                    style: TextStyle(
                        fontSize: 35,
                        color: HexColor("#175244"),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Text(
                "( Inclusive of packaging charge )",
              ),
            ],
          ),
        )
      ],
      body: datalist == null
          ? const CircularProgressIndicator()
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    toolbarHeight: 120,
                    backgroundColor: Colors.white,
                    foregroundColor: HexColor("#175244"),
                    title: Text(''),
                    pinned: false,
                    flexibleSpace: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Order",
                              style: TextStyle(
                                  fontSize: 30, color: HexColor("#175244")),
                            ),
                            Text(
                              "Summary",
                              style: TextStyle(
                                  fontSize: 35,
                                  color: HexColor("#175244"),
                                  fontWeight: FontWeight.w600),
                            ),
                          ]),
                    ),
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
                                                if (datalist[index].qty == 1) {
                                                  removefromcart(
                                                      datalist[index]);
                                                } else {
                                                  decreaseqty(datalist[index]);
                                                }
                                                setState(() {});
                                              },
                                              style: ButtonStyle(
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                          HexColor("#036635"))),
                                            ),
                                            Text(
                                                datalist[index].qty.toString()),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: () {
                                                increaseqty(datalist[index]);
                                                setState(() {});
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
  }
}
