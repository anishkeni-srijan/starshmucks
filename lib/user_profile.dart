import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: HexColor("#036635"),
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          //profile image
          CircleAvatar(
            radius: 150,
            backgroundColor: Colors.red,
            backgroundImage: AssetImage('images/profile1.jpg'),
          ),

          //name
          Align(
            alignment: Alignment.center,
            child: Text(
              'Name From DB',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                //Email Display
                Row(
                  children: [
                    Text(
                      'Email ID:  ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#036635"),
                      ),
                    ),
                    Text(
                      'something@gmail.com',
                      style: TextStyle(
                        fontSize: 20,
                        color: HexColor("#036635"),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //phone number
                Row(
                  children: [
                    Text(
                      'Phone Number:  ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#036635"),
                      ),
                    ),
                    Text(
                      '9999999999',
                      style: TextStyle(
                        fontSize: 20,
                        color: HexColor("#036635"),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //DOB
                Row(
                  children: [
                    Text(
                      'Date Of Birth:  ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#036635"),
                      ),
                    ),
                    Text(
                      'DD/MM/YY',
                      style: TextStyle(
                        fontSize: 20,
                        color: HexColor("#036635"),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
