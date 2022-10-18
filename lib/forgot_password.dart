import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/signin/signin.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final email = TextEditingController();

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
                top: 130.0,
                left: 48,
              ),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    'Forgot Password',
                    style: TextStyle(
                      color: HexColor("#036635"),
                      fontWeight: FontWeight.bold,
                    ),
                    minFontSize: 28,
                  )),
            ),
            Divider(
              color: HexColor("#036635"),
              height: 10,
              thickness: 3,
              indent: 49,
              endIndent: 288,
            ),
            SizedBox(
              height: 15,
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
                  labelText: 'Enter Email ID',
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
