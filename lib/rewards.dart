import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:starshmucks/home_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'boxes.dart';
import 'model/user_model.dart';

class Rewards extends StatefulWidget {
  const Rewards({Key? key}) : super(key: key);

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  @override
  Widget build(BuildContext context) {
    final box = Boxes.getUserData();
    final data = box.values.toList().cast<UserData>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Rewards'),
          backgroundColor: Colors.white,
          foregroundColor: HexColor("#175244"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Row(
                          children: [
                            Text(
                              '${'Hi ' + username}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            Icon(
                              Icons.stars_sharp,
                              color: Colors.amberAccent,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Welcome back!',
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    margin: EdgeInsets.only(top:90),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: HexColor("#036635"),
                    elevation: 4,
                    child: Container(
                     transform: Matrix4.translationValues(-10, 20, 0),
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                'My Points',
                                style: TextStyle(
                                  color: HexColor("#175244"),
                                ),
                                minFontSize: 23,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5.0,
                                ),
                                child: AutoSizeText(
                                  data[0].rewards.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: HexColor("#175244"),
                                  ),
                                  minFontSize: 23,
                                ),
                              ),
                              SizedBox(height: 60,),
                              ElevatedButton(style: ButtonStyle(backgroundColor:
                              MaterialStateProperty.all<Color>(HexColor('#175244')
                                 ),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.white   ),  ),onPressed: (){}, child: Text('Know More'))
                            ],
                          ),
                          Container(
                            transform: Matrix4.translationValues(45, -15,0),
                            child: Image.asset(
                              'images/icon.png',
                              width: 120,
                            ),
                          ),
                        ]),
                    ),),
                ),
              ],
            ),
            SizedBox(height: 20,),

            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.all(10),
              child: AutoSizeText(
                'You are 4 stars away from another reward',
                style: TextStyle(
                  color: HexColor("#175244"),
                ),
                minFontSize: 18,
              ),
            ),
            SizedBox(height: 20,),
           Padding(
             padding: const EdgeInsets.all(10.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text('Reward History'),
                 ListView.builder(
                   shrinkWrap: true,
                   itemCount: 2,
                   itemBuilder: (context, index) {
                   return Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text('order1'),
                       Text('20.0')
                     ],
                   );
                 },)

               ],
             ),
           )
          ],
        )));
  }
}
