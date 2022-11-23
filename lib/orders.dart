import 'package:flutter/material.dart';
import 'package:starshmucks/db/menu_db.dart';
import 'package:starshmucks/db/orders_db.dart';
import 'package:starshmucks/model/order_history.dart';
import 'boxes.dart';

import 'model/user_model.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var idlistfromstring;
  var qtylistfromstring;
  List<dynamic>data = [];
  List<dynamic>data1 = [];
  List<OrderHistoryModel>Orderdata = [];
  late OrdersDB orderdb;
  @override
  void initState() {
    orderdb = OrdersDB();
    orderdb.initDBOrders();
    getorderdata();
    super.initState();
  }
  getorderdata()async{

    data = await orderdb.getOrderId();
    for(var i = 0; i < data.length; i++)
    data1.add(data.first);
    print(data1);
    setState(() {
    });
  }
  // getDataIds() async {
  //   MenuDB menudb = MenuDB();
  //   Orderdata = await orderdb.getDataOrders();
  //   print("Order size:" + Orderdata.length.toString());
  //   for (var i = 0; i < Orderdata.length; i++) {
  //      idlistfromstring = Orderdata[i].id.split(' ');
  //      qtylistfromstring = Orderdata[i].qty.split(' ');
  //   }
  //   for (var i =0;i<idlistfromstring.length;i++){
  //     items = await menudb.getitemwithId_order(idlistfromstring[i]);
  //     items1.add(items.first);
  //   }
  //
  //   setState(() {});
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order'),
        ),
        body: ListView.builder(
          itemCount: data1.length,
          itemBuilder: (context, index) =>
                  Container(child: Text(data1[index].toString()),)
          ),
        );
  }
}
