import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '/model/user_model.dart';
import '../db/user_db.dart';
import 'bloc/editdetails_bloc.dart';
import 'bloc/editdetails_states.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

final picker = ImagePicker();

class _EditProfileState extends State<EditProfile> {
  File? imagefile;
  String saveImage = '';
  final ImagePicker picker = ImagePicker();
  late String obtainedemail;
  late String obtainedphone;
  late String obtainedname;
  late int obtainedkey;
  late TextEditingController econtroller;
  late TextEditingController ncontroller;
  late TextEditingController phcontroller;

  List<Map<String, dynamic>> usernames = [];
  getUser() async {
    usernames = await udb.getDataUserData();
    setState(() {});
  }

  late UserDB udb;
  void initState() {
    udb = UserDB();
    udb.initDBUserData();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (usernames.isEmpty)
      return CircularProgressIndicator();
    else {
      econtroller = TextEditingController(text: usernames[0]['email']);
      ncontroller = TextEditingController(text: usernames[0]['name']);
      phcontroller = TextEditingController(text: usernames[0]['phone']);
      return Scaffold(
          appBar: AppBar(
            title: Text("Edit Profile"),
            backgroundColor: Colors.white,
            foregroundColor: HexColor("#175244"),
          ),
          backgroundColor: HexColor("#175244"),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => showSelectionDialog());
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: usernames[0]['image'] == ''
                              ? DecorationImage(
                                  image: AssetImage(
                                      'images/profile1.jpg')) // set a placeholder image when no photo is set
                              : DecorationImage(
                                  image: FileImage(File(usernames[0]['image'])),
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
                      Container(
                          transform: Matrix4.translationValues(60, 150, 0),
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    usernames[0]['name'],
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
                  height: MediaQuery.of(context).size.height * 0.70,
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
                      BlocBuilder<EditdetailsBloc, EditdetailsState>(
                        builder: (context, state) {
                          //checking if There's an error in Loginstate
                          if (state is EditdetailsErrorState) {
                            return Text(
                              state.errormessage,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            );
                          }
                          //if the login is valid
                          else {
                            return Container();
                          }
                        },
                      ),
                      // DividerForTiles(),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .89,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              controller: econtroller,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                labelText: "Email",
                                labelStyle: TextStyle(
                                  color: HexColor("#175244"),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: HexColor("#175244"),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: HexColor("#175244"),
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!))
                                  return null;
                                else
                                  return "Please Enter a valid email";
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .89,
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Colors.black), //<-- SEE HERE
                              controller: phcontroller,

                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                labelText: "Phone1",
                                labelStyle: TextStyle(
                                  color: HexColor("#175244"),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: HexColor("#175244"),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: HexColor("#175244"),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .89,
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Colors.black), //<-- SEE HERE
                              controller: ncontroller,

                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                labelText: "Name",
                                labelStyle: TextStyle(
                                  color: HexColor("#175244"),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: HexColor("#175244"),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: HexColor("#175244"),
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null)
                                  return "Please enter name";
                                else if (value.length < 3)
                                  return "Please enter 3 character for name";
                                else
                                  return null;
                              },
                            ),
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
                        onPressed: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: HexColor("#175244"),
                              content: Text(
                                'Details Updated',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );

                          var updateData = UserModel(
                              tier: usernames[0]['tier'],
                              dob: usernames[0]['dob'],
                              email: econtroller.text,
                              phone: phcontroller.text,
                              name: ncontroller.text,
                              password: usernames[0]['password'],
                              rewards: usernames[0]['rewards'],
                              tnc: usernames[0]['tnc'],
                              image: usernames[0]['image']);
                          udb.updateUserData(usernames[0]['id'], updateData);
                          getUser();
                          setState(() {});
                        },
                        child: Text('UPDATE'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ));
    }
  }

  showSelectionDialog() {
    return Container(
      height: 100,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextButton.icon(
          onPressed: () {
            takepicture(ImageSource.camera);
          },
          icon: Icon(
            Icons.camera_alt_outlined,
            color: HexColor("#175244"),
          ),
          label: Text(
            'Click a picture now',
            style: TextStyle(color: HexColor("#175244")),
          ),
        ),
        TextButton.icon(
          onPressed: () {
            takepicture(ImageSource.gallery);
          },
          icon: Icon(Icons.image, color: HexColor("#175244")),
          label: Text(
            'Choose one from galary',
            style: TextStyle(color: HexColor("#175244")),
          ),
        )
      ]),
    );
  }

  takepicture(ImageSource source) async {
    final pickedfile = await picker.pickImage(source: source);
    imagefile = File(pickedfile!.path);

    saveImage = pickedfile.path;

    var updateData = UserModel(
        tier: usernames[0]['tier'],
        dob: usernames[0]['dob'],
        email: econtroller.text,
        phone: phcontroller.text,
        name: ncontroller.text,
        password: usernames[0]['password'],
        rewards: usernames[0]['rewards'],
        tnc: usernames[0]['tnc'],
        image: saveImage);
    udb.updateUserData(usernames[0]['id'], updateData);
    getUser();
    setState(() {});
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
