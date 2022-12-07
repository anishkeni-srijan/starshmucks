import 'package:flutter/material.dart';
import 'package:starshmucks/rewards.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'db/user_db.dart';

class Rewarddetails extends StatefulWidget {
  const Rewarddetails({Key? key}) : super(key: key);

  @override
  State<Rewarddetails> createState() => _RewarddetailsState();
}

class _RewarddetailsState extends State<Rewarddetails> {

  List<Map<String, dynamic>> usernames=[];
  UserDB udb = UserDB();
  getuser() async {
    usernames = await udb.getDataUserData();
    setState(() {

    });
  }

  @override
  void initState() {
  getuser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: HexColor("#175244"),backgroundColor: Colors.white,title: Text('Tier Benefits'),),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              detailTile(text: "bronze", press: (){}, color: Colors.brown),
              detailTile(text: "silver", press: (){}, color: Colors.grey),
              detailTile(text: "gold", press: (){}, color: Colors.amberAccent),
            ],
          ),
        ),
      ),
    );
  }
}
class detailTile extends StatelessWidget {
detailTile({
Key? key,
required this.text,
required this.press,
required this.color,
}) : super(key: key);
final String text;
final Color color;
final VoidCallback press;

@override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          elevation: 0,
          child:  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Card(
                    color: HexColor("#175244"),
                    margin: const EdgeInsets.only(top: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Colors.black,
                    elevation: 4,
                    child: Container(
                      height: 200,
                      child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            text=='bronze'?Container( width:
                                            MediaQuery.of(context).size.width * 0.365,):Container(
                                              width:
                                              MediaQuery.of(context).size.width * 0.365,
                                              child: LinearProgressIndicator(
                                                // color: Colors.white,
                                                backgroundColor:Colors.white,
                                                valueColor: new AlwaysStoppedAnimation<Color>(
                                                    Colors.brown),
                                                value: silvervalue,
                                              ),
                                            ),
                                            Icon(
                                              Icons.stars_sharp,
                                              color:
                                              text == 'gold'
                                                  ? Colors.amberAccent
                                                  : text ==
                                                  'silver'
                                                  ? Colors.grey
                                                  : Colors.brown,
                                            ),
                                            text == 'gold'?Container(width:
                                            MediaQuery.of(context).size.width * 0.365,):Container(
                                              width:
                                              MediaQuery.of(context).size.width * 0.365,
                                              child: LinearProgressIndicator(
                                                // color: Colors.white,
                                                backgroundColor:Colors.white,
                                                valueColor: new AlwaysStoppedAnimation<Color>(
                                                    Colors.brown),
                                                value: silvervalue,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text( text == 'gold'
                                            ? "Gold"
                                            : text ==
                                            'silver'
                                            ? "Silver"
                                            : "Bronze",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),)
                                      ],
                                    )
                    ),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 0,
                  ),
                  child: TextButton(
                    onPressed: press,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.stars_sharp,
                          size: 30,
                          color: color,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            text,
                            style: TextStyle(
                              color: HexColor("#036635"),
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Expanded(

                  child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        var res = index + 1;
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ListTile(
                            trailing: TextButton.icon(
                                onPressed: () {
                                },
                                icon: (Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black38,
                                )),
                                label: Text("askdgasd")),
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xff6ae792),
                              child: Text(
                                "d",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            title: Text(
                              "Order id: #" ,
                              style: TextStyle(fontSize: 14, color: HexColor("#175244")),
                            ),
                            subtitle: Text("Order Placed",
                                style: TextStyle(fontSize: 14, color: Colors.black38)),
                            onTap: () async {

                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 2,
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      
  );
}
}
