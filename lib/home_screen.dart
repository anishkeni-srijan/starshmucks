import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/user_profile.dart';
import '/boxes.dart';
import '/model/user_model.dart';
import 'package:get/get.dart';

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
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text("Name: " + data[index].name),
                  Text("DOB: " + data[index].dob),
                  Text("Ph: " + data[index].phone),
                  Text("email: " + data[index].email),
                  Text("email: " + data[index].password),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(UserProfile());
                      },
                      child: Text('Profile')),
                ],
              );
            }
          );
        },
      ),
    );
  }
}
