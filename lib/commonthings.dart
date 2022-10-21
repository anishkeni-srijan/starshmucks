import 'package:flutter/material.dart';
import 'package:starshmucks/home_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:starshmucks/home_screen.dart';
import 'package:starshmucks/user_profile.dart';

Widget getbottombar(BuildContext context) {
  bool homeroute = true;
  return Container(

    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      boxShadow: [
        BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              label: '',
              icon: TextButton.icon(
                icon:Icon(Icons.home_outlined, color: HexColor("#036635"),),
                label: Text(''),
                onPressed: () {
                  homeroute?null:
                  Get.to(HomePage());
                },
              ) ),
          BottomNavigationBarItem(
              label: '',
              icon: TextButton.icon(icon:Icon(Icons.person, color: HexColor("#036635")),
                label: Text(''),
                onPressed: () {
                  Get.to(UserProfile());
                  homeroute = false;
                },
              )),

        ],
      ),
    ),
  );
}




orderbutton(){
  return  FloatingActionButton(//Floating action button on Scaffold
      elevation: 10,
     backgroundColor:  Color(0xffb036635),
      onPressed: (){
      },
      child: Icon(Icons.coffee_maker_outlined,color: Colors.white,), //icon inside button
    );
}

