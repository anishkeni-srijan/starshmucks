import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var filteredUsers;
  late int  userkey;
getemail() async {
    final keypref = await SharedPreferences.getInstance();
    userkey = keypref.getInt('userkey')!;
    setState(() {

    });
    print(userkey);
   return userkey;
  }

  @override
  void initState() {
    // TODO: implement initState
    getemail();
    super.initState();
  }

  @override
  Widget build(BuildContext context)  {


    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<UserData>>(
        valueListenable: Boxes.getUserData().listenable(),
        builder: (context, box,  _) {
          final data = box.values.toList().cast<UserData>();


           return Column(
                 children: [

                   Text("Name: " + data[userkey].name),
                   Text("DOB: " + data[userkey].dob),
                   // Text("Ph: " + data[index].phone),
                   Text("email: " + data[userkey].email),
                   // Text("Password: " + data[index].password),
                   ElevatedButton(
                       onPressed: () {
                         Get.to(UserProfile());
                       },
                       child: Text('Profile')),
                 ],
               );
             }
           ),


      );


  }
}
