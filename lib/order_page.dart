import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '/common_things.dart';
import '/home_screen.dart';
import '/providers/menu_provider.dart';
import 'boxes.dart';
import 'db/Menu_Database.dart';
import 'model/cart_model.dart';
import 'model/menu_model.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController tabController;
  late MenuDB db;
  bool fetching = false;
  late var product;
  List<Menu> data = [];

  @override
  void initState() {
    db = MenuDB();
    db.initDB();
    getdata();
    putdata();
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  getdata() async {
    data = await db.getdata();
    setState(() {
      fetching = true;
    });
  }

  putdata() async {
    final String response =
        await DefaultAssetBundle.of(context).loadString("json/menu.json");
    final responseData = jsonDecode(response);
    for (var item = 0; item < responseData['Menu'].length; item++) {
      product = Menu.fromJson(responseData['Menu'][item]);
      print('adding ' + responseData['Menu'][item].toString());
      if (data.isNotEmpty && data.contains(product)) {
        print('items already exists');
      } else {
        db.insertData(product);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final menup = Provider.of<Menudata>(context);//
    // menup.cakefetchData(context);
    // menup.coffeefetchData(context);
    // menup.smoothiefetchData(context);
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            TabBar(
              controller: tabController,
              indicatorColor: HexColor("#175244"),
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.coffee,
                    color: HexColor("#175244"),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.cake_outlined,
                    color: HexColor("#175244"),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.local_drink_sharp,
                    color: HexColor("#175244"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  fetching
                      ? getcoffeedata()
                      : Center(child: CircularProgressIndicator()),
                  getcakedata(),
                  getsmoothiedata(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class getcakedata extends StatefulWidget {
  const getcakedata({Key? key}) : super(key: key);

  @override
  State<getcakedata> createState() => _getcakedataState();
}

class _getcakedataState extends State<getcakedata> {
  addToCart(context, index) async {
    late MenuDB db;
    db = MenuDB();
    print("in cart " + index.toString());
    final box = Boxes.getCartData();
    final data = box.values.toList().cast<CartData>();
    final cartp = await db.cakedata();
    final cartItem = CartData()
      ..title = cartp[index].title
      ..price = cartp[index].price
      ..qty = 1
      ..isInCart = true
      ..image = cartp[index].image
      ..ttlPrice = 0.0
      ..id = cartp[index].id;

    var zindex = data.indexWhere((item) => item.id == cartp[index].id);
    print("test " + zindex.toString());
    if (zindex != -1) {
      data[zindex].qty++;
      box.putAt(zindex, data[zindex]);
      print("already inn");
    } else {
      box.add(cartItem);
      print(cartItem.title);
    }
    setState(() {});
  }

  late MenuDB db;
  bool getdataf = false;
  List<Menu> data = [];
  @override
  void initState() {
    db = MenuDB();
    db.initDB();
    getdata();
    super.initState();
  }

  getdata() async {
    data = await db.cakedata();
    setState(() {
      getdataf = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('items in db: ' + data.length.toString());
    return Scaffold(
      persistentFooterButtons: cartinit ? [viewincart()] : null,
      body: getdataf
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                print(data[0].title);
                return GestureDetector(
                  onTap: () {
                    //getcoffeedetails(context, index);
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
                                        addToCart(context, index);
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

class getcoffeedata extends StatefulWidget {
  const getcoffeedata({Key? key}) : super(key: key);

  @override
  State<getcoffeedata> createState() => _getcoffeedataState();
}

class _getcoffeedataState extends State<getcoffeedata> {
  addToCart(context, index) async {
    late MenuDB db;
    db = MenuDB();
    print("in cart " + index.toString());
    final box = Boxes.getCartData();
    final data = box.values.toList().cast<CartData>();
    final cartp = await db.coffeedata();
    final cartItem = CartData()
      ..title = cartp[index].title
      ..price = cartp[index].price
      ..qty = 1
      ..isInCart = true
      ..image = cartp[index].image
      ..ttlPrice = 0.0
      ..id = cartp[index].id;

    var zindex = data.indexWhere((item) => item.id == cartp[index].id);
    print("test " + zindex.toString());
    if (zindex != -1) {
      data[zindex].qty++;
      box.putAt(zindex, data[zindex]);
      print("already inn");
    } else {
      box.add(cartItem);
      print(cartItem.title);
    }
    setState(() {});
  }

  late MenuDB db;
  bool getdataf = false;
  List<Menu> data = [];

  @override
  void initState() {
    db = MenuDB();
    db.initDB();
    getdata();
    super.initState();
  }

  getdata() async {
    data = await db.coffeedata();

    setState(() {
      getdataf = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('items in db: ' + data.length.toString());
    return Scaffold(
      persistentFooterButtons: cartinit ? [viewincart()] : null,
      body: getdataf
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // getcoffeedetails(context, index);
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
                                        addToCart(context, index);
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

class getsmoothiedata extends StatefulWidget {
  const getsmoothiedata(context, {Key? key}) : super(key: key);

  @override
  State<getsmoothiedata> createState() => _getsmoothiedataState();
}

class _getsmoothiedataState extends State<getsmoothiedata> {
  addToCart(context, index) async {
    late MenuDB db;
    db = MenuDB();
    print("in cart " + index.toString());
    final box = Boxes.getCartData();
    final data = box.values.toList().cast<CartData>();
    final cartp = await db.smoothiedata();
    final cartItem = CartData()
      ..title = cartp[index].title
      ..price = cartp[index].price
      ..qty = 1
      ..isInCart = true
      ..image = cartp[index].image
      ..ttlPrice = 0.0
      ..id = cartp[index].id;

    var zindex = data.indexWhere((item) => item.id == cartp[index].id);
    print("test " + zindex.toString());
    if (zindex != -1) {
      data[zindex].qty++;
      box.putAt(zindex, data[zindex]);
      print("already inn");
    } else {
      box.add(cartItem);
      print(cartItem.title);
    }
    setState(() {});
  }

  late MenuDB db;
  bool getdataf = false;
  List<Menu> data = [];

  @override
  void initState() {
    db = MenuDB();
    db.initDB();
    getdata();
    super.initState();
  }

  getdata() async {
    data = await db.smoothiedata();
    setState(() {
      getdataf = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('items in db: ' + data.length.toString());
    return Scaffold(
      persistentFooterButtons: cartinit ? [viewincart()] : null,
      body: getdataf
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // getcoffeedetails(context, index);
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
                                        addToCart(context, index);
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
