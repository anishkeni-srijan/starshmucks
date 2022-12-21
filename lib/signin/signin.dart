import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '/forgotpassword/forgot_password.dart';
import '../databse/user_db.dart';
import '../signup/signup.dart';
import 'bloc/signin_bloc.dart';
import 'bloc/signin_events.dart';
import 'bloc/signin_states.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final pcontroller = TextEditingController();
  final econtroller = TextEditingController();
  bool keeploggedin = false;
  late UserDB udb;

  @override
  void initState() {
    super.initState();
  }
  List<Map<String, dynamic>> userddt = [];
  getUser() async {
    udb.initDBUserData();
    userddt = await udb.getDataUserData();
    setState(() {

    });
  }


  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit this app'),
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
                const SizedBox(height: 20),
                BlocBuilder<SigninBloc, SigninState>(
                  builder: (context, state) {
                    //checking if There's an error in Loginstate
                    if (state is SigninErrorState) {
                      return Text(
                        state.errormessage,
                        style: const TextStyle(
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
                            ),
                          );
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
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
                    const SizedBox(height: 20),
                    //password
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: pcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
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
                      Get.to(() => const ForgotPasswordPage());
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
                          getUser();
                          if (userddt.isEmpty) {
                            BlocProvider.of<SigninBloc>(context).emit(
                              SigninErrorState("User Already Exists"),
                            );
                          } else {
                            BlocProvider.of<SigninBloc>(context).add(
                              SignupRedirect(),
                            );
                          }
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
  return const Image(
    image: AssetImage(
      'images/shmucks.png',
    ),
    width: 200,
  );
}
