import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      backgroundColor: HexColor("#175244"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  image: AssetImage('images/profile1.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all( Radius.circular(75.0)),
                border: Border.all(
                  color: Colors.white,
                  width: 4.0,
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Sanish Aukhale',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
            ),
            TextButton(onPressed: (){}, child: Text('Edit Profile', style: TextStyle(color: Colors.white),),),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
             color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),

              ),
              ),
              child: Column(
                children: [
                  profileTile(
                    text: 'My Account',
                    press: () {},
                    icon: Icons.account_circle_outlined,
                  ),
                  profileTile(
                    text: 'Orders',
                    press: () {},
                    icon: Icons.coffee_outlined,
                  ),
                  profileTile(
                    text: 'Rewards',
                    press: () {},
                    icon: Icons.star_outline_sharp,
                  ),
                  profileTile(
                    text: 'Payment Mode',
                    press: () {},
                    icon: Icons.attach_money_sharp,
                  ),
                  profileTile(
                    text: 'Help',
                    press: () {},
                    icon: Icons.help_outline_rounded,
                  ),
                  profileTile(
                    text: 'Logout',
                    press: () {Navigator.pop(context);Navigator.pop(context);},
                    icon: Icons.logout,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class profileTile extends StatelessWidget {
  const profileTile({
    Key? key,
    required this.text,
    required this.press,
    required this.icon,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      ),
      child: TextButton(

        onPressed: press,
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(20),
          // shape: Border(
          //     bottom: BorderSide({ width: 2.0,color: HexColor("#175244")}
          //     ),
          // ),

        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: HexColor("#036635"),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                    color: HexColor("#036635"),
                    fontWeight: FontWeight.w300,
                    fontSize: 20),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: HexColor("#036635"),
            ),
          ],
        ),
      ),
    );
  }
}
