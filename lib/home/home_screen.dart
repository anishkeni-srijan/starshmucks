import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:starshmucks/db/menu_db.dart';
import 'package:starshmucks/rewards.dart';
import 'package:get/get.dart';

import '../model/menu_model.dart';
import '/boxes.dart';
import '/model/user_model.dart';
import '../common_things.dart';
import '../providers/learnmore_provider.dart';
import 'now_serving.dart';
import 'offers_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool cartinit = false;
late String username;

class _HomePageState extends State<HomePage> {
  late MenuDB db ;
 List<Menu> data  = [];
  late var product;
  bool fetching = false;
  void initState() {
    db = MenuDB();
    db.initDBMenu();
    getdata();
    putdata();
    // cdb = CartDB();
    // cdb.initDBCart();
    super.initState();
  }

  getdata() async {
    data = await db.getDataMenu();
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
      // print('adding ' + responseData['Menu'][item].toString());
      if (data.isNotEmpty && data.contains(product)) {
        //  print('items already exists');
      } else {
        db.insertDataMenu(product);
      }
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // persistentFooterButtons: cartinit ? [viewincart()] : null,
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
