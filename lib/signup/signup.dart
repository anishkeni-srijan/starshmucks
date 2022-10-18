import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:starshmucks/signup/bloc/signup_events.dart';
import '../Signup/bloc/Signup_states.dart';
import '../signin/signin.dart';
import 'package:intl/intl.dart';
import 'package:starshmucks/signup/bloc/signup_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:starshmucks/model/user_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final List<UserData> signupdata = [];
  @override
  void dispose(){
    Hive.box('signupdata').close();
    super.dispose();
  }
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
  final dob = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final pass1 = TextEditingController();
  final pass2 = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  void initState() {
    dob.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: <Widget>[
            backbutton(context),
            getlogo(context),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
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
              height: MediaQuery.of(context).size.height * 0.015,
              thickness: MediaQuery.of(context).size.height * 0.004,
              indent: MediaQuery.of(context).size.width * 0.119,
              endIndent: MediaQuery.of(context).size.width * 0.746,
            ),
            SizedBox(
              height: 10,
            ),

            BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
              //checking if There's an error in Loginstate
              if (state is SignupErrorState) {
                return Text(
                  state.errormessage,
                  style: TextStyle(color: Colors.red),
                );
              }
              //if the login is valid
              else if(state is SignupValidState) {
                return Container();
              }
              else return Container();
            }),

            //Name
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
              ),
              child: TextFormField(
                style: const TextStyle(color: Colors.black), //<-- SEE HERE
                controller: name,
                onChanged: (value) {
                  BlocProvider.of<SignupBloc>(context).add(SignupNameChangedEvent(name.text));
                },
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
            //Date of Birth
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005,
              ),
              child: TextField(
                controller: dob, //editing controller of this TextField
                onChanged: (value) {
                  BlocProvider.of<SignupBloc>(context).add(
                      SignupDobChangedEvent(dob.text));
                },
                decoration:
                InputDecoration(
                  //label text of field
                    contentPadding: EdgeInsets.all(5),
                    labelText: 'Date Of Birth',
                    labelStyle: TextStyle(
                      color: HexColor("#175244"),
                    ),
                    prefixIcon: Icon(Icons.calendar_month_rounded, color: HexColor("#175244"),) ,

                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: HexColor("#175244"), width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: HexColor("#175244"), width: 2),
                    )
                ),
                readOnly: true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );

                  if (pickedDate != null) {
                    print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement
                    setState(() {
                      dob.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
            //Email
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005,
              ),
              child: TextFormField(
                style: const TextStyle(color: Colors.black), //<-- SEE HERE
                controller: email,
                onChanged: (value) {
                  BlocProvider.of<SignupBloc>(context)
                      .add(SignupEmailChangedEvent(email.text));
                },
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
            //Phone Number
            //Phone Number
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  BlocProvider.of<SignupBloc>(context)
                      .add(SignupNumberChangedEvent(phone.text));
                },
                selectorConfig: SelectorConfig(
                    trailingSpace: false,
                    selectorType: PhoneInputSelectorType.DROPDOWN),
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: HexColor("#175244")),
                initialValue: number,
                textFieldController: phone,
                inputDecoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  labelText: 'Phone Number',
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
                  ),
                ),

                keyboardType: TextInputType.numberWithOptions(
                  signed: true,
                ),
                //inputBorder: OutlineInputBorder(),
              ),
            ),
            //Password
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005,
              ),
              child: TextFormField(
                obscureText: true,
                style: const TextStyle(color: Colors.black), //<-- SEE HERE
                controller: pass1,
                onChanged: (value) {
                  BlocProvider.of<SignupBloc>(context)
                      .add(SignupPasswordChangedEvent(pass1.text));
                },
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
            //Confirm Password
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005,
              ),
              child: TextFormField(
                obscureText: true,
                style: const TextStyle(color: Colors.black), //<-- SEE HERE
                controller: pass2,
                onChanged: (value) {
                  BlocProvider.of<SignupBloc>(context).add(SignupConfirmPasswordChangedEvent(pass2.text,pass1.text));
                },
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
            //CheckBox
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
                      BlocProvider.of<SignupBloc>(context)
                          .add(SignuptandcChangedEvent(isChecked));


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

  backbutton(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30, left: 0),
        alignment: Alignment.topLeft,
        child: TextButton.icon(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: HexColor("#036635")),
          onPressed: () {
            Navigator.pop(context);
          },
          label: Text(''),
        ));
  }
}




