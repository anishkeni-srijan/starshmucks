import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:starshmucks/providers/learnmore_provider.dart';
import 'package:starshmucks/providers/nowserving_provider.dart';

import '/boxes.dart';
import '/model/user_model.dart';
import 'commonthings.dart';

import 'package:starshmucks/providers/offers_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

late String username;

class _HomePageState extends State<HomePage> {
  late int userkey;

  getemail() async {
    final keypref = await SharedPreferences.getInstance();
    userkey = keypref.getInt('userkey')!;
    setState(() {});
    print(userkey);

    return userkey;
  }

  @override
  void initState() {
    // TODO: implement initState

    getemail();
    super.initState();
  }

  final econtroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nowservep = Provider.of<OffersData>(context);
    nowservep.fetchData(context);
    return Scaffold(
      floatingActionButton: orderbutton(),
      appBar: gethomeappbar(),
      bottomNavigationBar: getbottombar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ValueListenableBuilder<Box<UserData>>(
        valueListenable: Boxes.getUserData().listenable(),
        builder: (context, box, _) {
          final data = box.values.toList().cast<UserData>();
          username = data[userkey].name;
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
                    )),
               getoffers(context),
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
                nowserving(context),
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

gethomeappbar() {
  return AppBar(
    backgroundColor: Colors.white,
    title: Text(
      'Starschmucks',
      style: TextStyle(
        color: HexColor("#175244"),
        fontWeight: FontWeight.w600,
      ),
    ),
    elevation: 5,
    actions: [
      IconButton(
        color: HexColor("#175244"),
        onPressed: () {},
        icon: const Icon(
          Icons.notifications_outlined,
        ),
      ),
    ],
    automaticallyImplyLeading: false,
  );
}

getbanner(context, username) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.2,
    decoration: new BoxDecoration(
      color: HexColor("#175244"),
      image: new DecorationImage(
        fit: BoxFit.cover,
        colorFilter: new ColorFilter.mode(
          Colors.black.withOpacity(0.05),
          BlendMode.dstATop,
        ),
        image: new ExactAssetImage('images/shmucks.png'),
      ),
    ),
    child: Column(
      children: [
        Container(
          transform: Matrix4.translationValues(0, 28, 0),
          child: Text(
            'Hi ' + username + '!',
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
                    minFontSize: 20,
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
                  )),
              Container(
                transform: Matrix4.translationValues(
                  15,
                  5,
                  0,
                ),
                child: IconButton(
                  onPressed: () {},
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

getoffers(context) {
  final offersp = Provider.of<OffersData>(context);
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.18,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      //   shrinkWrap: true,
        itemCount: offersp.offerdata.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(width: 10,),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:index % 2 == 0 ? Colors.teal
                :Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width * 0.76,
                child: Stack(
                  children: [
                    Container(
                     transform: Matrix4.translationValues(-10, 20, 0),
                      child: Image.asset(
                        offersp.offerdata[index].image,
                        width: 150,
                        height: 150,
                      ),
                    ),
                    Container(
                      child: Container(
                        // transform: Matrix4.translationValues(-120, 10, 0),
                        margin: EdgeInsets.only(top: 10, left: 130),
                        child: Text(
                          offersp.offerdata[index].offer,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 130),
                      child: Text(
                        offersp.offerdata[index].title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Container(
                      // transform: Matrix4.translationValues(-320, 40, 0),
                      margin: EdgeInsets.only(top:85, left: 190),
                      child: TextButton(
                        onPressed: () {},
                        child: Text('Order Now'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(HexColor('#175244')),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
            ],
          );

        }),
  );
}
nowserving(context) {
  final nowservep = Provider.of<NowServing>(context);
  nowservep.fetchData(context);
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.18,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,

        itemCount: nowservep.nowdata.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(width: 10,),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:index % 2 == 0 ? Colors.deepOrangeAccent
                :Colors.teal,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width * 0.76,
                child: Stack(
                  children: [
                    Container(
                     transform: Matrix4.translationValues(-10, 20, 0),
                      child: Image.asset(
                        nowservep.nowdata[index].image,
                        width: 150,
                        height: 150,
                      ),
                    ),
                    Container(
                      child: Container(
                        // transform: Matrix4.translationValues(-120, 10, 0),
                        margin: EdgeInsets.only(top: 10, left: 130),
                        child: Text(
                          nowservep.nowdata[index].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 130),
                      child: Text(
                        nowservep.nowdata[index].tag,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Container(
                      // transform: Matrix4.translationValues(-320, 40, 0),
                      margin: EdgeInsets.only(top:85, left: 190),
                      child: TextButton(
                        onPressed: () {},
                        child: Text('Order Now'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(HexColor('#175244')),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
            ],
          );

        }),
  );
}
learnmore(context) {
  final learnmorep = Provider.of<Learnmore>(context);
  learnmorep.fetchData(context);
  return SizedBox(
 height: 250,
    child: ListView.builder(itemCount:learnmorep.learnmore.length,
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
                          fontWeight: FontWeight.w600),
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
