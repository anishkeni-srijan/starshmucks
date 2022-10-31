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
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final menup = Provider.of<Menudata>(context);
    menup.cakefetchData(context);
    menup.coffeefetchData(context);
    menup.smoothiefetchData(context);
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: gethomeappbar(),
        body: Column(
          children: [
            TabBar(
              controller: tabController,
              indicatorColor: HexColor("#175244"),
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.coffee,
                    color: HexColor("#175244"),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.cake_outlined,
                    color: HexColor("#175244"),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.local_drink_sharp,
                    color: HexColor("#175244"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  getcoffee(context),
                  getcake(context),
                  getsmoothie(context),
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

getcake(context) {
  final menup = Provider.of<Menudata>(context);
  return ListView.builder(
    itemCount: menup.cakemenudata.length,
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
                    menup.cakemenudata[index].image,
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
                      menup.cakemenudata[index].title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06,
                    left: 130,
                  ),
                  child: Text(
                    menup.cakemenudata[index].category,
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
        ],
      );
    },
  );
}

getsmoothie(context) {
  final menup = Provider.of<Menudata>(context);
  return ListView.builder(
    itemCount: menup.smoothiemenudata.length,
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
                    menup.smoothiemenudata[index].image,
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
                      menup.smoothiemenudata[index].title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 60,
                    left: 130,
                  ),
                  child: Text(
                    menup.smoothiemenudata[index].category,
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
        ],
      );
    },
  );
}

getcoffee(context) {
  final menup = Provider.of<Menudata>(context);
  return ListView.builder(
    itemCount: menup.coffeemenudata.length,
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
                    menup.coffeemenudata[index].image,
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
                      menup.coffeemenudata[index].title,
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
                    menup.coffeemenudata[index].category,
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
        ],
      );
    },
  );
}
