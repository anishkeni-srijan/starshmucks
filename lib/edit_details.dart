import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'boxes.dart';
import 'model/user_model.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  getemail() async {
    final keypref = await SharedPreferences.getInstance();
    userkey = keypref.getInt('userkey')!;
    setState(() {});
    print(userkey);
    return userkey;
  }

  @override
  var userkey;
  void initState() {
    getemail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: HexColor("#175244"),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      backgroundColor: HexColor("#175244"),
      body: ValueListenableBuilder<Box<UserData>>(
        valueListenable: Boxes.getUserData().listenable(),
        builder: (context, box, _) {
          final data = box.values.toList().cast<UserData>();
          final econtroller = TextEditingController(text: data[userkey].email);
          final ncontroller = TextEditingController(text: data[userkey].name);
          final phcontroller = TextEditingController(text: data[userkey].phone);

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      image: AssetImage('images/profile1.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(75.0),
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 4.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    data[userkey].name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.60,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      // DividerForTiles(),
                      Row(
                        children: [
                          EditableField(
                            econtroller: econtroller,
                            lbltxt: 'Email',
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          EditableField(
                            econtroller: phcontroller,
                            lbltxt: 'Phone',
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          EditableField(
                            econtroller: ncontroller,
                            lbltxt: 'Name',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            HexColor("#175244"),
                          ),
                        ),
                        onPressed: () {
                          data[userkey].name = ncontroller.text;
                          data[userkey].email = econtroller.text;
                          data[userkey].phone = phcontroller.text;
                          box.putAt(userkey, data[userkey]);
                          setState(() {});
                        },
                        child: Text('UPDATE'),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class EditableField extends StatelessWidget {
  const EditableField({
    Key? key,
    required this.econtroller,
    required this.lbltxt,
  }) : super(key: key);

  final TextEditingController econtroller;
  final String lbltxt;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        autocorrect: false,
        style: const TextStyle(
          color: Colors.black,
        ),
        controller: econtroller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: lbltxt,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
