import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '/boxes.dart';
import '/model/user_model.dart';
import 'commonthings.dart';

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
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          height: MediaQuery.of(context).size.height * 0.18,
          width: MediaQuery.of(context).size.width * 0.76,
          child: Stack(
            children: [
              Container(
                transform: Matrix4.translationValues(
                  -25,
                  0,
                  0,
                ),
                child: Image.asset(
                  'images/christmas.png',
                ),
              ),
              Container(
                child: Container(
                  transform: Matrix4.translationValues(
                    105,
                    10,
                    0,
                  ),
                  child: Text(
                    'Join us this Christmas.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  105,
                  40,
                  0,
                ),
                child: Text(
                  'A Schtarry Decade',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  180,
                  80,
                  0,
                ),
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
        SizedBox(
          width: 10,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(20),
          ),
          height: MediaQuery.of(context).size.height * 0.18,
          width: MediaQuery.of(context).size.width * 0.76,
          child: Stack(
            children: [
              Container(
                transform: Matrix4.translationValues(
                  -15,
                  0,
                  0,
                ),
                child: Image.asset(
                  'images/buytwo.png',
                ),
              ),
              Container(
                child: Container(
                  transform: Matrix4.translationValues(
                    145,
                    20,
                    0,
                  ),
                  child: Text(
                    'Buy 2,',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  145,
                  40,
                  0,
                ),
                child: Text(
                  'For the Price of 1.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  180,
                  80,
                  0,
                ),
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
        SizedBox(
          width: 10,
        ),
      ],
    ),
  );
}

nowserving(context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(20),
          ),
          height: MediaQuery.of(context).size.height * 0.18,
          width: MediaQuery.of(context).size.width * 0.76,
          child: Stack(
            children: [
              Container(
                transform: Matrix4.translationValues(
                  5,
                  10,
                  0,
                ),
                child: Image.asset(
                  'images/newone.png',
                  width: 100,
                ),
              ),
              Container(
                child: Container(
                  transform: Matrix4.translationValues(
                    105,
                    10,
                    0,
                  ),
                  child: Text(
                    'Watermelon Sugar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  105,
                  40,
                  0,
                ),
                child: Text(
                  'Tastes like strawberries On a summer evenin\'',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  180,
                  80,
                  0,
                ),
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
        SizedBox(
          width: 10,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height * 0.18,
          width: MediaQuery.of(context).size.width * 0.76,
          child: Stack(
            children: [
              Container(
                transform: Matrix4.translationValues(
                  20,
                  0,
                  0,
                ),
                child: Image.asset(
                  'images/newtwo.png',
                ),
              ),
              Container(
                child: Container(
                  transform: Matrix4.translationValues(
                    120,
                    20,
                    0,
                  ),
                  child: Text(
                    'Lorem Ipsum',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  120,
                  40,
                  0,
                ),
                child: AutoSizeText(
                  'Lorem Ipsum is simply typesetting.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  180,
                  80,
                  0,
                ),
                child: TextButton(
                    onPressed: () {},
                    child: Text('Order Now'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            HexColor('#175244')),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ))),
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    ),
  );
}

learnmore(context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
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
          height: MediaQuery.of(context).size.height * 0.32,
          width: MediaQuery.of(context).size.width * 0.86,
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  'images/learnmore.png',
                  width: 250,
                ),
              ),
              Container(
                child: Container(
                  child: Text(
                    'Learn More',
                    style: TextStyle(
                        color: HexColor('#175244'),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
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
  );
}
