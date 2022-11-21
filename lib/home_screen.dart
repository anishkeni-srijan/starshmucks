

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:starshmucks/rewards.dart';
import '/model/cart_model.dart';
import 'package:get/get.dart';

import '/boxes.dart';
import '/model/user_model.dart';
import 'common_things.dart';
import 'db/nowserve_db.dart';
import 'db/offers_db.dart';
import 'model/nowserving_model.dart';
import 'model/offers_model.dart';
import 'providers/learnmore_provider.dart';
import '/providers/nowserving_provider.dart';
import '/providers/offers_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool cartinit = false;
late String username;

class _HomePageState extends State<HomePage> {
  late NowServeDb nowdb;
  late OffersDb offerdb;

  List<NowServe> nowdata = [];
  List<Offer> offerdata = [];

  @override
  void initState() {
    nowdb = NowServeDb();
    nowdb.initNowServedb();
    offerdb = OffersDb();
    offerdb.initOffersdb();
    getdata();
    // putnowdata();
    putofferdata();
    super.initState();
  }

  getdata() async {
    nowdata = await nowdb.NowServedata();
    offerdata = (await offerdb.Offersdata()).cast<Offer>();
    setState(() {
    });
  }
  putnowdata() async {
    final String response =
    await DefaultAssetBundle.of(context).loadString("json/nowserve.json");
    final responseData = jsonDecode(response);
    for (var item = 0; item < responseData['NowServe'].length; item++) {
     var product = NowServe.fromJson(responseData['NowServe'][item]);
      print('adding ' + responseData['NowServe'][item].toString());
      nowdb.insertnowserveData(product);

    }
  }

  putofferdata() async {
    final String response =
    await DefaultAssetBundle.of(context).loadString("json/offers.json");
    final responseData = jsonDecode(response);
    for (var item = 0; item < responseData['Offers'].length; item++) {
      var offproduct = Offer.fromJson(responseData['Offers'][item]);
      print('adding ' + responseData['Offers'][item].toString());
      offerdb.insertOffersData(offproduct);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: cartinit ? [viewincart()] : null,
      body: ValueListenableBuilder<Box<UserData>>(
        valueListenable: Boxes.getUserData().listenable(),
        builder: (context, box, _) {
          final udata = box.values.toList().cast<UserData>();
          username = udata[0].name;
          return SingleChildScrollView(
            child: Column(
              children: [
                getbanner(context, username),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    'Offers',
                    style: TextStyle(
                      color: HexColor("#175244"),
                      fontWeight: FontWeight.w700,
                    ),
                    minFontSize: 25,
                  ),
                ),
                getoffers(),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    'Now Serving',
                    style: TextStyle(
                      color: HexColor("#175244"),
                      fontWeight: FontWeight.w700,
                    ),
                    minFontSize: 25,
                  ),
                ),
                nowserving(),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    'Learn More About Our Drinks',
                    style: TextStyle(
                      color: HexColor("#175244"),
                      fontWeight: FontWeight.w700,
                    ),
                    minFontSize: 25,
                  ),
                ),
                learnmore(context),
              ],
            ),
          );
        },
      ),
    );
  }
}

getbanner(context, username) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.2,
    decoration: BoxDecoration(
      color: HexColor("#175244"),
      image: DecorationImage(
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.05),
          BlendMode.dstATop,
        ),
        image: ExactAssetImage('images/shmucks.png'),
      ),
    ),
    child: Column(
      children: [
        Container(
          transform: Matrix4.translationValues(0, 28, 0),
          child: Text(
            '${'Hi ' + username}!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            bottom: 20,
            left: 20,
          ),
          transform: Matrix4.translationValues(
            0,
            80,
            0,
          ),
          child: Row(
            children: [
              Container(
                transform: Matrix4.translationValues(
                  3,
                  -8,
                  0,
                ),
                child: Image.asset(
                  'images/stars.png',
                  width: 20,
                ),
              ),
              Column(
                children: [
                  AutoSizeText(
                    '1/5',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    minFontSize: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 2.0,
                      left: 8,
                    ),
                    child: AutoSizeText(
                      'Stars',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      minFontSize: 12,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                transform: Matrix4.translationValues(
                  0,
                  -8,
                  0,
                ),
                child: Icon(
                  Icons.card_giftcard,
                  color: Colors.amber,
                  size: 13,
                ),
              ),
              Column(
                children: [
                  Container(
                    transform: Matrix4.translationValues(
                      -18,
                      0,
                      0,
                    ),
                    child: AutoSizeText(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      minFontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 2.0,
                      left: 8,
                    ),
                    child: AutoSizeText(
                      'Rewards',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      minFontSize: 12,
                    ),
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                transform: Matrix4.translationValues(
                  30,
                  4,
                  0,
                ),
                child: AutoSizeText(
                  'You are 4 stars away from another reward',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  minFontSize: 15,
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  15,
                  5,
                  0,
                ),
                child: IconButton(
                  onPressed: () {
                    Get.to(Rewards());
                  },
                  icon: Icon(
                    Icons.play_arrow_sharp,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// getofferdetails(context, index) {
//   final offersp = Provider.of<Offers>(context, listen: false);
//   return showModalBottomSheet<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return SingleChildScrollView(
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height * 0.75,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Image.asset(
//                 data[index].image,
//                 width: MediaQuery.of(context).size.width * 0.52,
//                 height: MediaQuery.of(context).size.height * 0.52,
//               ),
//               Container(
//                   margin: EdgeInsets.all(20),
//                   alignment: Alignment.centerLeft,
//                   child: AutoSizeText(offersp.offerdata[index].title)),
//               Container(
//                   margin: EdgeInsets.only(left: 20, right: 20),
//                   alignment: Alignment.centerLeft,
//                   child: AutoSizeText(offersp.offerdata[index].desc)),
//               Container(
//                 margin: EdgeInsets.only(left: 20, right: 20),
//                 alignment: Alignment.centerLeft,
//                 child: Row(
//                   children: [
//                     AutoSizeText("\$" + offersp.offerdata[index].price),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.52,
//                     ),
//                     ElevatedButton(onPressed: () {}, child: Text('Add')),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

// getnowservedetails(context, index) {
//   final Offerp = Provider.of<NowServing>(context, listen: false);
//   return showModalBottomSheet<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.75,
//           child: Column(
//             children: <Widget>[
//               Image.asset(
//                 Offerp.nowdata[index].image,
//                 width: MediaQuery.of(context).size.width * 0.52,
//                 height: MediaQuery.of(context).size.height * 0.52,
//               ),
//               Container(
//                   margin: EdgeInsets.all(20),
//                   alignment: Alignment.centerLeft,
//                   child: AutoSizeText(Offerp.nowdata[index].title)),
//               Container(
//                 margin: EdgeInsets.only(left: 20, right: 20),
//                 alignment: Alignment.centerLeft,
//                 child: AutoSizeText(Offerp.nowdata[index].desc),
//               ),
//               Container(
//                   margin: EdgeInsets.only(left: 20, right: 20),
//                   alignment: Alignment.centerLeft,
//                   child: Row(
//                     children: [
//                       AutoSizeText('\$' + Offerp.nowdata[index].price),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.52,
//                       ),
//                       ElevatedButton(onPressed: () {}, child: Text('Add')),
//                     ],
//                   )),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

class getoffers extends StatefulWidget {
  const getoffers({Key? key}) : super(key: key);

  @override
  State<getoffers> createState() => _getoffersState();
}

class _getoffersState extends State<getoffers> {

  late OffersDb db;
  bool getdataf = false;
  late var product;
  List<Offer> odata = [];

  @override
  void initState() {
    db = OffersDb();
    db.initOffersdb();
    getdata();
    super.initState();
  }

  getdata() async {
    odata = (await db.Offersdata()).cast<Offer>();
    setState(() {
      getdataf = true;
    });
  }

  addToCart(context, index) {
    print("in cart " + index.toString());
    final box = Boxes.getCartData();
    final cdata = box.values.toList().cast<CartData>();
    final cartp = Provider.of<OffersData>(context, listen: false);
    final cartItem = CartData()
      ..title = cartp.offerdata[index].title
      ..price = cartp.offerdata[index].price
      ..qty = 1
      ..isInCart = true
      ..image = cartp.offerdata[index].image
      ..ttlPrice = 0.0
      ..id = cartp.offerdata[index].id;
    int zindex =
        cdata.indexWhere((item) => item.id == cartp.offerdata[index].id);
    print("test " + zindex.toString());
    if (zindex != -1) {
      cdata[zindex].qty++;
      box.putAt(zindex, cdata[zindex]);
      print("already inn");
    } else {
      box.add(cartItem);
      print(cartItem.title);
    }
  }
  @override
  Widget build(BuildContext context) {
    print('offerdata len' + odata.length.toString());
    return ValueListenableBuilder<Box<CartData>>(
        valueListenable: Boxes.getCartData().listenable(),
        builder: (context, box, _) {
          bool flag = false;
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
                       // getofferdetails(context, index);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? Colors.teal
                              : Colors.deepOrangeAccent,
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
                                  top: 10,
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
                                top: 30,
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
                                  setState(() {
                                    cartinit = true;
                                  });
                                },
                                child: flag ? Text('Added') : Text("Add"),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
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
        });
  }
}

class nowserving extends StatefulWidget {
  const nowserving({Key? key}) : super(key: key);

  @override
  State<nowserving> createState() => _nowservingState();
}

class _nowservingState extends State<nowserving> {
  addToCart(context, index) {
    print("in cart " + index.toString());
    final box = Boxes.getCartData();
    final cdata = box.values.toList().cast<CartData>();
    final cartp = Provider.of<NowServing>(context, listen: false);
    final cartItem = CartData()
      ..title = cartp.nowdata[index].title
      ..price = cartp.nowdata[index].price
      ..qty = 1
      ..isInCart = true
      ..image = cartp.nowdata[index].image
      ..ttlPrice = 0.0
      ..id = cartp.nowdata[index].id;
    int zindex = cdata.indexWhere((item) => item.id == cartp.nowdata[index].id);
    print("test " + zindex.toString());
    if (zindex != -1) {
      cdata[zindex].qty++;
      box.putAt(zindex, cdata[zindex]);
      print("already inn");
    } else {
      box.add(cartItem);
      print(cartItem.title);
    }
  }
  late NowServeDb db;
  bool getdataf = false;
  List<NowServe> nowdata = [];
  late var product;
  @override
  void initState() {
    db = NowServeDb();
    db.initNowServedb();
    getdata();
    super.initState();
  }

  getdata() async {
    nowdata = await db.NowServedata();
    setState(() {
      getdataf = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    print('nowdata len' + nowdata.length.toString());
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
                  //getnowservedetails(context, index);
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
                          //   final box = Boxes.getCartData();
                          //   final data = box.values.toList().cast<CartData>();

                            // if (data.contains(data[index])) {
                            //   //update qty
                            //   print('imhere');
                            //   return null;
                            // } else
                            //   addToCart(context, index);
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

learnmore(context) {
  final learnmorep = Provider.of<Learnmore>(context);
  learnmorep.fetchData(context);
  return SizedBox(
    height: 250,
    child: ListView.builder(
      itemCount: learnmorep.learnmore.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HexColor('#ebd8a7'),
                  Colors.white,
                ],
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.42,
            width: MediaQuery.of(context).size.width * 0.86,
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    learnmorep.learnmore[index].image,
                    width: 250,
                  ),
                ),
                Container(
                  child: Container(
                    child: Text(
                      learnmorep.learnmore[index].title,
                      style: TextStyle(
                        color: HexColor('#175244'),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    learnmorep.learnmore[index].tag,
                    style: TextStyle(
                      color: HexColor('#175244'),
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
