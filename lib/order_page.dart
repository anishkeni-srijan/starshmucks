import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
                  children:  <Widget>[
                    getcoffee(context),
                   getcake(context),
                    getsmoothie(context),

                  ],
                ),
            ),
          ],
        ),
        ),
    );
  }
}

getcoffee(context) {
  final menup = Provider.of<Menudata>(context);
  return Container(
    child: ListView.builder(
      itemCount: menup.coffeemenudata.length,
      itemBuilder: (context, index) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.18,
          decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: HexColor("#175244"), width: 1)),),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, //change here don't //worked
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, bottom: 20),
                transform: Matrix4.translationValues(-10, 20, 0),
                child: Image.asset(
                  menup.coffeemenudata[index].image,
                  width: 150,
                  height: 150,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      menup.coffeemenudata[index].title,
                      style: TextStyle(
                        color: Colors.black,

                      ),
                      maxFontSize: 18,
                      maxLines: 1,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width*0.03,),
                    Text(
                      " \$ " + menup.coffeemenudata[index].price,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width*0.06,),
                    Row(
                      children: <Widget>[
                        AutoSizeText( menup.coffeemenudata[index].rating , style:  TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                          minFontSize: 12,
                          maxFontSize: 18,

                        ),Icon(Icons.star, size: 20, color: Colors.amberAccent,),
                        Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.22),
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Order Now'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                index % 2 == 0
                                    ? Colors.teal
                                    : Colors.deepOrangeAccent),
                            foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                        ),
                      ),],
                    ),

                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

getcake(context) {
  final menup = Provider.of<Menudata>(context);
  return Container(
    child: ListView.builder(
      itemCount: menup.cakemenudata.length,
      itemBuilder: (context, index) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.18,
          decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: HexColor("#175244"), width: 1)),),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, //change here don't //worked

            children: [
              Container(
                padding: EdgeInsets.only(left: 10, bottom: 20),
                transform: Matrix4.translationValues(-10, 20, 0),
                child: Image.asset(
                  menup.cakemenudata[index].image,
                  width: 150,
                  height: 150,
                ),
              ),
              Container(

                height:MediaQuery.of(context).size.height*0.25 ,
                width: MediaQuery.of(context).size.width*0.55,
                padding: EdgeInsets.only(top: 15,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      menup.cakemenudata[index].title,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                   maxLines: 1,
                      maxFontSize: 18,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width*0.03,),
                    Text(
                      " \$ " + menup.cakemenudata[index].price,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width*0.06,),
                    Row(
                      children: <Widget>[
                        AutoSizeText( menup.cakemenudata[index].rating , style:  TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                          minFontSize: 12,
                          maxFontSize: 18,

                        ),Icon(Icons.star, size: 20, color: Colors.amberAccent,),
                        Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.2),
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Order Now'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                index % 2 == 0
                                    ? Colors.teal
                                    : Colors.deepOrangeAccent),
                            foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                        ),
                      ),],
                    ),

                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
getsmoothie(context) {
  final menup = Provider.of<Menudata>(context);
  return Container(
    child: ListView.builder(
      itemCount: menup.smoothiemenudata.length,
      itemBuilder: (context, index) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.18,
          decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: HexColor("#175244"), width: 1)),),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, //change here don't //worked
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, bottom: 20),
                transform: Matrix4.translationValues(-10, 20, 0),
                child: Image.asset(
                  menup.smoothiemenudata[index].image,
                  width: 150,
                  height: 150,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      menup.smoothiemenudata[index].title,
                      style: TextStyle(
                        color: Colors.black,

                      ),
                      maxLines: 1,
                      maxFontSize: 18,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width*0.03,),
                    Text(
                      " \$ " + menup.smoothiemenudata[index].price,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width*0.06,),
                    Row(
                      children: <Widget>[
                        AutoSizeText( menup.smoothiemenudata[index].rating , style:  TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                          minFontSize: 12,
                          maxFontSize: 18,

                        ),Icon(Icons.star, size: 20, color: Colors.amberAccent,),
                        Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.22),
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Order Now'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                index % 2 == 0
                                    ? Colors.teal
                                    : Colors.deepOrangeAccent),
                            foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                        ),
                      ),],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
