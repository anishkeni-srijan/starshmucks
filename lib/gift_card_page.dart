import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'commonthings.dart';
import 'home_screen.dart';

class GiftCardPage extends StatefulWidget {
  const GiftCardPage({Key? key}) : super(key: key);

  @override
  State<GiftCardPage> createState() => _GiftCardPageState();
}

class _GiftCardPageState extends State<GiftCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethomeappbar(),
      floatingActionButton: orderbutton(),
      bottomNavigationBar: getbottombar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
