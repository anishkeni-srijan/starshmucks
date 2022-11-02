import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'commonthings.dart';
import 'home_screen.dart';

class GiftCard extends StatefulWidget {
  const GiftCard({Key? key}) : super(key: key);

  @override
  State<GiftCard> createState() => _GiftCardState();
}

class _GiftCardState extends State<GiftCard> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      giftCardDesign(
                        image: 'images/giftdiwali.png',
                        giftCardText:
                            'Gift For Diwali.You can gift this to your sister for Bhai Dooj',
                        price: 'Rs 659.00',
                        titleText: 'Celebrate With Starshmucks',
                        press: () {},
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      giftCardDesign(
                        image: 'images/giftdiwali2.png',
                        giftCardText:
                            'Gift For Diwali.You can gift this to your sister for Bhai Dooj',
                        price: 'Rs.999.00',
                        titleText: 'Celebrate With Starshmucks',
                        press: () {},
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TabBar(
              controller: tabController,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              // indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: HexColor("#175244"),

              labelColor: Colors.black,
              // unselectedLabelColor: Colors.black,
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  text: 'ALL',
                ),
                Tab(
                  text: 'FEATURED',
                ),
                Tab(
                  text: 'CONGRATULATIONS',
                ),
                Tab(
                  text: 'THANK YOU',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  getAllCards(context),
                  getAllCards(context),
                  getAllCards(context),
                  getAllCards(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class giftCardDesign extends StatelessWidget {
  const giftCardDesign({
    Key? key,
    required this.image,
    required this.giftCardText,
    required this.price,
    required this.titleText,
    required this.press,
  }) : super(key: key);
  final String image;
  final String titleText;
  final String giftCardText;

  final VoidCallback press;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: HexColor("#ede38c"), borderRadius: BorderRadius.circular(20)),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.79,
      child: Stack(
        children: [
          Container(
            transform: Matrix4.translationValues(5, 12, 0),
            child: Image.asset(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            child: Container(
              transform: Matrix4.translationValues(100, 10, 0),
              child: Text(
                titleText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Container(
            width: 200,
            transform: Matrix4.translationValues(
              100,
              40,
              0,
            ),
            child: Text(
              giftCardText,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(30, 130, 0),
            child: AutoSizeText(
              'Starting from',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(30, 145, 0),
            child: AutoSizeText(
              price,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(200, 120, 0),
            child: TextButton(
              onPressed: press,
              child: Text('Gift Now'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(HexColor("#175244")),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

getAllCards(context) {
  return Container(
    margin: EdgeInsets.all(20),
    child: ListView(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: HexColor("#ede38c"),
              borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.50,
          child: Stack(
            children: [
              Container(
                transform: Matrix4.translationValues(5, 12, 0),
                child: Image.asset(
                  'images/giftdiwali.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                child: Container(
                  transform: Matrix4.translationValues(110, 10, 0),
                  child: Text(
                    'Celebrate With Starshmucks',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Container(
                width: 220,
                transform: Matrix4.translationValues(
                  110,
                  40,
                  0,
                ),
                child: Text(
                  'Gift For Diwali.You can gift this to your sister for Bhai Dooj',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(30, 130, 0),
                child: AutoSizeText(
                  'Starting from',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(30, 145, 0),
                child: AutoSizeText(
                  'Rs.659.00',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  250,
                  120,
                  0,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text('Gift Now'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(HexColor("#175244")),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: HexColor("#ede38c"),
              borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.50,
          child: Stack(
            children: [
              Container(
                transform: Matrix4.translationValues(5, 12, 0),
                child: Image.asset(
                  'images/giftdiwali.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                child: Container(
                  transform: Matrix4.translationValues(110, 10, 0),
                  child: Text(
                    'Celebrate With Starshmucks',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Container(
                width: 220,
                transform: Matrix4.translationValues(
                  110,
                  40,
                  0,
                ),
                child: Text(
                  'Gift For Diwali.You can gift this to your sister for Bhai Dooj',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(30, 130, 0),
                child: AutoSizeText(
                  'Starting from',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(30, 145, 0),
                child: AutoSizeText(
                  'Rs.659.00',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  250,
                  120,
                  0,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text('Gift Now'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(HexColor("#175244")),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: HexColor("#ede38c"),
              borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.50,
          child: Stack(
            children: [
              Container(
                transform: Matrix4.translationValues(5, 12, 0),
                child: Image.asset(
                  'images/giftdiwali.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                child: Container(
                  transform: Matrix4.translationValues(110, 10, 0),
                  child: Text(
                    'Celebrate With Starshmucks',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Container(
                width: 220,
                transform: Matrix4.translationValues(
                  110,
                  40,
                  0,
                ),
                child: Text(
                  'Gift For Diwali.You can gift this to your sister for Bhai Dooj',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(30, 130, 0),
                child: AutoSizeText(
                  'Starting from',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(30, 145, 0),
                child: AutoSizeText(
                  'Rs.659.00',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  250,
                  120,
                  0,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text('Gift Now'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(HexColor("#175244")),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
