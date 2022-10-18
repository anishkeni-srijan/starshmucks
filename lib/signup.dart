import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hexcolor/hexcolor.dart';

import 'signin/signin.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isChecked = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return HexColor("#036635");
  }

  final name = TextEditingController();
  final email = TextEditingController();
  final pass1 = TextEditingController();
  final pass2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: <Widget>[
            getlogo(context),
            Padding(
              padding: const EdgeInsets.only(
                top: 140.0,
                left: 46,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  'Sign up.',
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
              height: 10,
              thickness: 3,
              indent: 47,
              endIndent: 293,
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
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: HexColor("#175244"),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: HexColor("#175244"), width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: HexColor("#175244"), width: 2),
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
                    labelText: 'Email',
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
                      borderSide:
                          BorderSide(color: HexColor("#175244"), width: 2),
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
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: HexColor("#175244"),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: HexColor("#175244"), width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: HexColor("#175244"), width: 2),
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
                    color: HexColor("#175244"),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: HexColor("#175244"), width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: HexColor("#175244"), width: 2),
                  ),
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(30, 0, 0),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    focusColor: Colors.green,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                  ),
                  AutoSizeText(
                    'T&C, I agree.',
                    style: TextStyle(color: HexColor("#175244")),
                  )
                ],
              ),
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
