import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'boxes.dart';

import 'model/user_model.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    final box = Boxes.getUserData();
    final data = box.values.toList().cast<UserData>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Order'),
        ),
        body: Text('')
        // ListView.builder(
        //   itemCount: data.length,
        //   itemBuilder: (context, index) =>
        //
        //
        //   ,),
        );
  }
}
