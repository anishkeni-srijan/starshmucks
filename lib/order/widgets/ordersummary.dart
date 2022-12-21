import 'package:flutter/material.dart';

import '../../model/order_history.dart';
import 'package:hexcolor/hexcolor.dart';


class ordersummary extends StatelessWidget {
  const ordersummary({
    Key? key,
    required this.OrderData,
  }) : super(key: key);

  final List<OrderHistoryModel> OrderData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          "Order Summary",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: HexColor("#175244")),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment:
          MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.date_range_outlined,
              size: 20.0,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "${OrderData[0].date}",
              style:
              TextStyle(fontSize: 15),
            ),
          ],
        ),
      ],
    );
  }
}