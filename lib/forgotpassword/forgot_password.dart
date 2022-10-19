import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:starshmucks/forgotpassword/bloc/forgotpassword_bloc.dart';
import 'package:starshmucks/forgotpassword/bloc/forgotpassword_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_auth/email_auth.dart';
import 'package:starshmucks/password_reset.dart';
import 'bloc/forgotpassword_event.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final forgotpasswordinput = TextEditingController();
  final otpinput = TextEditingController();
  bool submitValid = false;
  bool verificationflag = false;
  late EmailAuth emailAuth;

  @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 30, left: 0),
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                      color: HexColor("#036635")),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: Text(''),
                )),
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
              height: MediaQuery.of(context).size.height * 0.015,
              thickness: MediaQuery.of(context).size.height * 0.004,
              indent: MediaQuery.of(context).size.width * 0.126,
              endIndent: MediaQuery.of(context).size.width * 0.658,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 300,
              child: AutoSizeText(
                  'Please enter your details and We\'ll send you a OTP.',
                  style: TextStyle(
                    color: HexColor("#175244"),
                  )),
            ),
            BlocBuilder<ForgotpasswordBloc, ForgotpasswordState>(
                builder: (context, state) {
              //checking if There's an error in Loginstate
              if (state is ForgotpasswordErrorState) {
                return Text(
                  state.errormessage,
                  style: TextStyle(color: Colors.red),
                );
              }
              //if the login is valid
              else if (state is ForgotpasswordValidState) {
                return Text(
                  state.validity,
                  style: TextStyle(color: HexColor("#036635")),
                );
              } else
                return Container();
            }),
            submitValid
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005,
                    ),
                    child: TextFormField(
                      style:
                          const TextStyle(color: Colors.black), //<-- SEE HERE
                      controller: otpinput,
                      onChanged: (value) {
                        verify();
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Enter the Verification Code',
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
                  )
                : Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005,
                    ),
                    child: TextFormField(
                      style:
                          const TextStyle(color: Colors.black), //<-- SEE HERE
                      controller: forgotpasswordinput,
                      onChanged: (value) {
                        BlocProvider.of<ForgotpasswordBloc>(context).add(
                            ForgotpasswordInputChangedEvent(
                                forgotpasswordinput.text));
                        sendOtp();
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Email or Phone Number',
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
                onPressed: submitValid ? verify : sendOtp,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60)),
                  backgroundColor: HexColor("#036635"),
                ),
                child: submitValid
                    ? Text(
                        'Verify',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Reset Password',
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

  void verify() {

    emailAuth.validateOtp(
            recipientMail: forgotpasswordinput.value.text,
            userOtp: otpinput.value.text)
        ? verificationflag = true
        : verificationflag = false;

    verificationflag? Get.to(PasswordResetPage()):print('wrongotp');
  }


  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: forgotpasswordinput.value.text, otpLength: 5);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
  }

}
