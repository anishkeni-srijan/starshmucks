import 'package:flutter/material.dart';

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
      body: Text(data[0].orders.toString()),
    );
  }
}
