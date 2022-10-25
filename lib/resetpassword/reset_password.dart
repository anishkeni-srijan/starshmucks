import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../boxes.dart';
import 'bloc/resetpassword_bloc.dart';
import 'bloc/resetpassword_event.dart';
import 'bloc/resetpassword_state.dart';
import '/model/user_model.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late int resetuserkey;
  geteuserkey() async {
    final keypref = await SharedPreferences.getInstance();
    resetuserkey = keypref.getInt('resetuserkey')!;
    setState(() {});
    print(resetuserkey);
    return resetuserkey;
  }

  @override
  void initState() {
    // TODO: implement initState
    geteuserkey();
    super.initState();
  }

  bool reset = false;
  var passwordcontroller = TextEditingController();
  var confirmpasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ValueListenableBuilder<Box<UserData>>(
          valueListenable: Boxes.getUserData().listenable(),
          builder: (context, box, _) {
            final data = box.values.toList().cast<UserData>();
            return Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 30,
                      left: 0,
                    ),
                    alignment: Alignment.topLeft,
                    child: TextButton.icon(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: HexColor("#036635"),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: Text(''),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 100.0,
                      left: 48,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        'Reset Password',
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
                    indent: MediaQuery.of(context).size.width * 0.126,
                    endIndent: MediaQuery.of(context).size.width * 0.69,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 300,
                    child: reset
                        ? AutoSizeText(
                            'Successfully Reset, Redirecting to Sign in in 5 seconds.',
                            style: TextStyle(
                              color: HexColor("#175244"),
                            ),
                          )
                        : AutoSizeText(
                            'Let\'s rest your password.',
                            style: TextStyle(
                              color: HexColor("#175244"),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<ResetpasswordBloc, ResetpasswordState>(
                    builder: (context, state) {
                      //checking if There's an error in Loginstate
                      if (state is ResetpasswordErrorState) {
                        return Text(
                          state.errormessage,
                          style: TextStyle(color: Colors.red),
                        );
                      }
                      //if the login is valid
                      else if (state is ResetpasswordValidState) {
                        return Text(
                          state.validity,
                          style: TextStyle(
                            color: HexColor("#036635"),
                          ),
                        );
                      } else if (state is ResetpasswordConfirmState) {
                        return Text(
                          state.message,
                          style: TextStyle(
                            color: HexColor("#036635"),
                          ),
                        );
                      } else
                        return Container();
                    },
                  ),
                  BlocBuilder<ResetpasswordBloc, ResetpasswordState>(
                    builder: (context, state) {
                      if (state is ResetpasswordConfirmState) {
                        return Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: CircularProgressIndicator(
                            color: HexColor("#036635"),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: TextFormField(
                                obscureText: true,
                                style: const TextStyle(color: Colors.black),
                                controller: passwordcontroller,
                                onChanged: (value) {
                                  BlocProvider.of<ResetpasswordBloc>(context)
                                      .add(
                                    PasswordChangedEvent(
                                      passwordcontroller.text,
                                    ),
                                  );
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  labelText: 'New Password',
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.005,
                              ),
                              child: TextFormField(
                                obscureText: true,
                                style: const TextStyle(
                                    color: Colors.black), //<-- SEE HERE
                                controller: confirmpasswordcontroller,
                                onChanged: (value) {
                                  BlocProvider.of<ResetpasswordBloc>(context)
                                      .add(
                                    ConfirmpasswordChangedEvent(
                                        passwordcontroller.text,
                                        confirmpasswordcontroller.text),
                                  );
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  labelText: 'Confirm New Password',
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
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: 300,
                              child: ElevatedButton(
                                onPressed: () {
                                  data[resetuserkey].password =
                                      passwordcontroller.text;
                                  box.putAt(resetuserkey, data[resetuserkey]);
                                  reset = true;
                                  setState(() {});
                                  BlocProvider.of<ResetpasswordBloc>(context)
                                      .add(ResetpasswordSubmittedEvent());
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  backgroundColor: HexColor("#036635"),
                                ),
                                child: Text(
                                  'Reset Password',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
