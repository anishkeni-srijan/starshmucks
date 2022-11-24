import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starshmucks/db/menu_db.dart';
import 'package:starshmucks/db/orders_db.dart';
import 'package:starshmucks/model/menu_model.dart';
import 'package:starshmucks/model/order_history.dart';
import 'package:hexcolor/hexcolor.dart';

class Orderdetail extends StatefulWidget {
  const Orderdetail({Key? key}) : super(key: key);

  @override
  State<Orderdetail> createState() => _OrderdetailState();
}

class _OrderdetailState extends State<Orderdetail> {
  late OrdersDB orderdb;
  late int? id = 0;
  List<OrderHistoryModel> orderdata = [];
  List<dynamic> idlistfromstring = [];
  List<dynamic> qtylistfromstring = [];
  List<MenuModel> items= [];
  List<MenuModel> items1= [];

  @override
  void initState() {
    getorderid();
    super.initState();
  }

  getorderid() async {
    final prefs = await SharedPreferences.getInstance();
   id = (await prefs.getInt('orderid'))!;
   setState(() {

   });

  }

  getorderdetails(id) async {
    MenuDB menudb = MenuDB();
    menudb.initDBMenu();
    print("sending id to db:" + id.toString());
    orderdb = OrdersDB();
    orderdb.initDBOrders();
    orderdata = await orderdb.getDataOrderswrtID(id);
    for(var i = 0; i < orderdata.length;i++)
      {
        idlistfromstring = orderdata[i].id!.split(' ');
        qtylistfromstring = orderdata[i].qty!.split(' ');
      }
    for (var i =0;i<idlistfromstring.length;i++){
      items = await menudb.getitemwithId_order(idlistfromstring[i]);
      items1.add(items.first);
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    getorderdetails(id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body:SingleChildScrollView(
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Order id: #"+id.toString(),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              Divider(
                color: HexColor("#175244"),
                height: 1,
                thickness: 0.5,
                indent: 0,
                endIndent: 0,
              ),
               SizedBox(
                width: 400,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: qtylistfromstring.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 5,
                              top: 5),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              orderdata.isEmpty || items1.isEmpty
                                  ? Center(child: Text('updating...'),)
                                  :Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 150,
                                      child: Text(
                                          items1[index].title.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow
                                              .ellipsis)),
                                  Text(
                                      qtylistfromstring[index]+
                                          ' x qty'),
                                ],
                              ),
                              // Column(
                              //     crossAxisAlignment:
                              //         CrossAxisAlignment.end,
                              //     children: [
                              //       Row(children: [
                              //         AutoSizeText(
                              //           "\$ " + data[index].price,
                              //           minFontSize: 10,
                              //         ),
                              //       ]),
                              //      ])
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Divider(
                  color: HexColor("#175244"),
                  height: 1,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cart total",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        // Text(
                        //   "\$ " + data[0].ttlPrice.toStringAsFixed(2),
                        //   style: TextStyle(fontWeight: FontWeight.w300),
                        // ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Points savings",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        Text(
                          '-\$ 10.00',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Charges",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "\$ 5.00",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        // Text(
                        //   "\$ " +
                        //       (data[0].ttlPrice - 10.0 + 5.00)
                        //           .toStringAsFixed(2),
                        //   style: TextStyle(fontWeight: FontWeight.w600),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Divider(
                  color: HexColor("#175244"),
                  height: 1,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Deliver to:",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    // Text(
                    //   selectedAddress.toString(),
                    //   style: TextStyle(fontWeight: FontWeight.w300),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
      ),

    );
  }
}
