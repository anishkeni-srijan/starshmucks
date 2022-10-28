import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'commonthings.dart';
import 'home_screen.dart';

class GiftCardPage extends StatefulWidget {
  const GiftCardPage({Key? key}) : super(key: key);

  @override
  State<GiftCardPage> createState() => _GiftCardPageState();
}

class _GiftCardPageState extends State<GiftCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethomeappbar(),
      floatingActionButton: orderbutton(),
      bottomNavigationBar: getbottombar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: HexColor("#175244"),
      body: Container(
          height: MediaQuery.of(context).size.height * .30,
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: HexColor("#ede38c"),
                      borderRadius: BorderRadius.circular(20)),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.79,
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
                          transform: Matrix4.translationValues(100, 10, 0),
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
                        transform: Matrix4.translationValues(
                          100,
                          40,
                          0,
                        ),
                        child: AutoSizeText(
                          'Gift For Diwali.\nYou can gift this to your \nsister for Bhai Dooj',
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
                          'Rs.659.00',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(200, 120, 0),
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Gift Now'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                HexColor("#175244")),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: HexColor("#ede38c"),
                      borderRadius: BorderRadius.circular(20)),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.79,
                  child: Stack(
                    children: [
                      Container(
                        transform: Matrix4.translationValues(5, 12, 0),
                        child: Image.asset(
                          'images/giftdiwali2.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Container(
                        child: Container(
                          transform: Matrix4.translationValues(100, 10, 0),
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
                        transform: Matrix4.translationValues(
                          100,
                          40,
                          0,
                        ),
                        child: AutoSizeText(
                          'Gift For Diwali.\nYou can gift this to your \nsister for Bhai Dooj',
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
                          'Rs.999.00',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(200, 120, 0),
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Gift Now'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                HexColor("#175244")),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                  width: 10,
                ),
              ],
            ),
          )),
    );
  }
}
