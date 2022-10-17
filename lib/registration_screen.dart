import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hexcolor/hexcolor.dart';

import 'login/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final pass1 = TextEditingController();
  final pass2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getappbar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: <Widget>[
            getlogo(context),
            Padding(
              padding: const EdgeInsets.only(
                top: 60.0,
                left: 46,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  'REGISTER',
                  style: TextStyle(
                      color: HexColor("#036635"),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                  minFontSize: 28,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005,
              ),
              child: TextFormField(
                style: const TextStyle(color: Colors.black), //<-- SEE HERE
                controller: name,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  labelText: 'NAME',
                  labelStyle: TextStyle(
                    color: HexColor("#036635"),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: HexColor("#036635"), width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: HexColor("#036635"), width: 2),
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
                style: const TextStyle(color: Colors.black), //<-- SEE HERE
                controller: email,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    labelText: 'EMAIL',
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
                      borderSide:
                          BorderSide(color: HexColor("#036635"), width: 2),
                    )),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005,
              ),
              child: TextFormField(
                obscureText: true,
                style: const TextStyle(color: Colors.black), //<-- SEE HERE
                controller: pass1,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  labelText: 'PASSWORD',
                  labelStyle: TextStyle(
                    color: HexColor("#036635"),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: HexColor("#036635"), width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: HexColor("#036635"), width: 2),
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
                style: const TextStyle(color: Colors.black), //<-- SEE HERE
                controller: pass2,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(
                    color: HexColor("#036635"),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: HexColor("#036635"), width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: HexColor("#036635"), width: 2),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60)),
                  backgroundColor: HexColor("#036635"),
                ),
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
