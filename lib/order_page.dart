import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:starshmucks/home_screen.dart';
import 'commonthings.dart';
class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethomeappbar(),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: HexColor("#175244"),
              ),
              height: MediaQuery.of(context).size.height*0.3, child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,child: Text("What's on your mind?", style: TextStyle(color: Colors.white, fontSize: 20))),
                  Row(children: [
                    GestureDetector(
                      child:  Container(
                        margin: EdgeInsets.all(20),
                        width: 90.0,
                        height: 90.0,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: AssetImage('images/profile1.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(75.0),
                          ),
                          border: Border.all(
                            color: Colors.white,
                            width: 4.0,
                          ),
                        ),
                      ),
                    ),GestureDetector(
                      child:  Container(
                        margin: EdgeInsets.all(20),
                        width: 90.0,
                        height: 90.0,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: AssetImage('images/profile1.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(75.0),
                          ),
                          border: Border.all(
                            color: Colors.white,
                            width: 4.0,
                          ),
                        ),
                      ),
                    ),GestureDetector(
                      child:  Container(
                        margin: EdgeInsets.all(20),
                        width: 90.0,
                        height: 90.0,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: AssetImage('images/profile1.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(75.0),
                          ),
                          border: Border.all(
                            color: Colors.white,
                            width: 4.0,
                          ),
                        ),
                      ),
                    )
                  ]),
                ],
              ),)
          ],
        ),
      ),
      floatingActionButton: orderbutton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: getbottombar(context),
    );
  }
}
