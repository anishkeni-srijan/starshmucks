import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/boxes.dart';
import '/model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<UserData>>(
        valueListenable: Boxes.getUserData().listenable(),
        builder: (context, box, _) {
          final data = box.values.toList().cast<UserData>();
          return Container(
            child: Column(
              children: [
                Text("Name: " + data[1].name),
                Text("DOB: " + data[1].dob),
                Text("Ph: " + data[1].phone),
                Text("email: " + data[1].email),
                Text("email: " + data[1].password),
              ],
            ),
          );
        },
      ),
    );
  }
}
