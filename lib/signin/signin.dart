import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../db/user_db.dart';
import 'bloc/signin_bloc.dart';
import 'bloc/signin_events.dart';
import 'bloc/signin_states.dart';
import '/forgotpassword/forgot_password.dart';
import '../signup/signup.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final pcontroller = TextEditingController();
  final econtroller = TextEditingController();
  late String obtainedemail;
  late String obtainedpassword;

  bool keeploggedin = false;
  late UserDB udb;
  void initState() {
    udb = UserDB();
    udb.initDBUserData();
    getUser();
    super.initState();
  }

  List<Map<String, dynamic>> userddt = [];
  getUser() async {
    userddt = await udb.getDataUserData();
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No', style: TextStyle(color: HexColor("#175244"))),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: Text(
                  'Yes',
                  style: TextStyle(color: HexColor("#175244")),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    if (userddt.isEmpty) {
      obtainedemail = '';
      obtainedpassword = '';
    } else {
      obtainedemail = userddt[0]['email'];
      obtainedpassword = userddt[0]['password'];
    }
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: null,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.12,
                  ),
                  child: getlogo(context),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 50.0,
                    left: 48,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      'Sign In.',
                      style: TextStyle(
                        color: HexColor("#036635"),
                        fontWeight: FontWeight.bold,
                      ),
                      minFontSize: 28,
                    ),
                  ),
                ),
                Divider(
                  color: HexColor("#036635"),
                  height: MediaQuery.of(context).size.height * 0.015,
                  thickness: MediaQuery.of(context).size.height * 0.004,
                  indent: MediaQuery.of(context).size.width * 0.119,
                  endIndent: MediaQuery.of(context).size.width * 0.746,
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<SigninBloc, SigninState>(
                  builder: (context, state) {
                    //checking if There's an error in Loginstate
                    if (state is SigninErrorState) {
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

                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: TextFormField(
                        autocorrect: false,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        controller: econtroller,
                        onChanged: (value) {
                          BlocProvider.of<SigninBloc>(context).add(
                            SigninemailChangedEvent(
                              econtroller.text,
                              obtainedemail,
                            ),
                          );
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: HexColor("#036635"),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: HexColor("#036635"),
                              width: 2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: HexColor("#036635"),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    //password
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: pcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: HexColor("#036635"),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: HexColor("#036635"),
                              width: 2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: HexColor("#036635"),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextButton(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: HexColor("#036635"),
                      ),
                    ),
                    onPressed: () {
                      Get.to(
                        // ForgotPasswordPage(),
                        ForgotPasswordPage(),
                      );
                    },
                  ),
                ),
                //submit button,
                BlocBuilder<SigninBloc, SigninState>(
                  builder: (context, state) {
                    return Container(
                      transform: Matrix4.translationValues(0, -15, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: (state is SigninValidState)
                              ? MaterialStateProperty.all<Color>(
                                  Colors.white,
                                )
                              : MaterialStateProperty.all<Color>(
                                  HexColor("#036635"),
                                ),
                          foregroundColor: (state is SigninValidState)
                              ? MaterialStateProperty.all<Color>(
                                  HexColor("#036635"),
                                )
                              : MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              side: BorderSide(
                                color: HexColor("#036635"),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          BlocProvider.of<SigninBloc>(context).add(
                            SigninpassChangedEvent(
                              pcontroller.text,
                              obtainedpassword,
                            ),
                          );

                          // setState(() {});
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                Container(
                  transform: Matrix4.translationValues(
                    135,
                    -20,
                    0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'New User?',
                        style: TextStyle(
                          color: HexColor("#036635"),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (userddt.isEmpty)
                            Get.to(SignupPage());
                          else
                            print("User Already there");
                        },
                        child: Text(
                          'Sign Up.',
                          style: TextStyle(
                            color: HexColor("#036635"),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getlogo(context) {
  return Image(
    image: AssetImage(
      'images/shmucks.png',
    ),
    width: 200,
  );
}
