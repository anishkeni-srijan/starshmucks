import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:starshmucks/home_screen.dart';
import 'package:starshmucks/providers/menu_provider.dart';
import 'commonthings.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3,vsync: this);
  }
  @override
  Widget build(BuildContext context) {
   final menup = Provider.of<Menudata>(context);
   menup.fetchData(context);
    return DefaultTabController(
        initialIndex: 1,
        length: 3,
      child: Scaffold(
        appBar: gethomeappbar(),
        body: Column(
            children: [
              Container(
                child: TabBar(
                  indicatorColor: HexColor("#175244"),
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.coffee, color: HexColor("#175244"),),
                    ),
                    Tab(
                      icon: Icon(Icons.cake_outlined,color: HexColor("#175244"),),
                    ),
                    Tab(
                      icon: Icon(Icons.local_drink_sharp, color: HexColor("#175244"),),
                    ),
                  ],
                ),
              ),
         Expanded(
           child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  SizedBox(

                    child: getcoffee(context),
                  ),
                  Center(
                    child: Text("It's rainy here"),
                  ),
                  Center(
                    child: Text("It's sunny here"),
                  ),
                ],
              ),
         ),

            ],
          ),
        floatingActionButton: orderbutton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: getbottombar(context),
      ),
    );
  }
}

getoptions(context) {
  return Row(children: [
    GestureDetector(
      child: Container(
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
    ),
    GestureDetector(
      child: Container(
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
    ),
    GestureDetector(
      child: Container(
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
  ]);
}
getcoffee(context){
  final menup = Provider.of<Menudata>(context);
  return ListView.builder(
    itemCount: menup.menudata.length,
    itemBuilder: (context, index) {
      return Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: index % 2 == 0 ? Colors.teal : Colors.deepOrangeAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            height: MediaQuery.of(context).size.height * 0.18,
            width: MediaQuery.of(context).size.width * 0.76,
            child: Stack(
              children: [
                Container(
                  transform: Matrix4.translationValues(-10, 20, 0),
                  child: Image.asset(
                    menup.menudata[index].image,
                    width: 150,
                    height: 150,
                  ),
                ),
                Container(
                  child: Container(
                    // transform: Matrix4.translationValues(-120, 10, 0),
                    margin: EdgeInsets.only(
                      top: 10,
                      left: 130,
                    ),
                    child: Text(
                      menup.menudata[index].title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 130,
                  ),
                  child: Text(
                    menup.menudata[index].category,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  // transform: Matrix4.translationValues(-320, 40, 0),
                  margin: EdgeInsets.only(
                    top: 85,
                    left: 190,
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
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    },
  );
}