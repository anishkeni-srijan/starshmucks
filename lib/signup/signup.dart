import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '/db/user_db.dart';
import '/signup/bloc/signup_bloc.dart';
import '/signup/bloc/signup_events.dart';
import '../model/user_model.dart';
import '../signin/signin.dart';
import 'bloc/signup_states.dart';

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
  final dob = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final pass1 = TextEditingController();
  final pass2 = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  late UserDB udb;

  void initState() {
    udb = UserDB();
    udb.initDBUserData();

    dob.text = ""; //set the initial value of text field
    super.initState();
  }

  void addUserData() {
    //sqflite UserModel
    var userSQL = UserModel(
      tier: "bronze",
      name: name.text,
      email: email.text,
      phone: phone.text,
      dob: dob.text,
      password: pass1.text,
      tnc: true.toString(),
      rewards: 0,
      image: '',
    );
    udb.insertUserData(userSQL);
    udb.getDataUserData();
  }

  Future<bool> getToSignin() async {
    return (await Get.to(() => SigninPage())) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: getToSignin,
      child: Scaffold(
        appBar: null,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
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

                BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    //checking if There's an error in Loginstate
                    if (state is SignupErrorState) {
                      return Text(
                        state.errormessage,
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    //if the login is valid
                    else if (state is SignupValidState) {
                      return Container();
                    } else
                      return Container();
                  },
                ),

                //Name
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: name,
                      onChanged: (value) {
                        BlocProvider.of<SignupBloc>(context).add(
                          SignupNameChangedEvent(name.text),
                        );
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        labelText: 'Name',
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
                ),
                //Date of Birth
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: dob,
                      //editing controller of this TextField
                      onChanged: (value) {
                        BlocProvider.of<SignupBloc>(context).add(
                          SignupDobChangedEvent(dob.text),
                        );
                      },
                      decoration: InputDecoration(
                        //label text of field
                        contentPadding: EdgeInsets.all(5),
                        labelText: 'Date Of Birth',
                        labelStyle: TextStyle(
                          color: HexColor("#175244"),
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_month_rounded,
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
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                            1900,
                            1,
                            1,
                          ),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate);
                          setState(
                            () {
                              dob.text =
                                  formattedDate; //set output date to TextField value.
                            },
                          );
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                ),
                //Email
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      autocorrect: false,
                      style: const TextStyle(color: Colors.black),
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
                ),
                //Phone Number
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 80,
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      BlocProvider.of<SignupBloc>(context).add(
                        SignupNumberChangedEvent(phone.text),
                      );
                    },
                    selectorConfig: SelectorConfig(
                        trailingSpace: false,
                        selectorType: PhoneInputSelectorType.DROPDOWN),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    errorMessage: "Enter Valid Phone Number",
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
                        borderSide: BorderSide(
                          color: HexColor("#175244"),
                          width: 2,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                //Password
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      obscureText: true,
                      style: const TextStyle(color: Colors.black),
                      controller: pass1,
                      onChanged: (value) {
                        BlocProvider.of<SignupBloc>(context).add(
                          SignupPasswordChangedEvent(pass1.text),
                        );
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        labelText: 'Password',
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
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        if (!regex.hasMatch(value!))
                          return """* Minimum 1 Upper case\n* Minimum 1 lowercase\n* Minimum 1 Numeric Number\n* Minimum 1 Special Character\n* Common Allow Character ( ! @ # \$ & * ~ )""";
                        else
                          return null;
                      },
                    ),
                  ),
                ),
                //Confirm Password
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      controller: pass2,
                      onChanged: (value) {
                        BlocProvider.of<SignupBloc>(context).add(
                          SignupConfirmPasswordChangedEvent(
                            pass2.text,
                            pass1.text,
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        labelText: 'Confirm Password',
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
                        if (value == null) return "Enter the password";
                        if (value != pass1.text)
                          return "Password doesn't match";
                      },
                    ),
                  ),
                ),
                //CheckBox
                Container(
                  transform: Matrix4.translationValues(
                    30,
                    0,
                    0,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        focusColor: Colors.green,
                        value: isChecked,
                        onChanged: (bool? value) {
                          BlocProvider.of<SignupBloc>(context).add(
                            SignuptandcChangedEvent(isChecked),
                          );
                          setState(
                            () {
                              isChecked = !isChecked;
                            },
                          );
                        },
                      ),
                      AutoSizeText(
                        'T&C, I agree.',
                        style: TextStyle(
                          color: HexColor("#175244"),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isChecked) {
                        BlocProvider.of<SignupBloc>(context).add(
                          SignupSumittedEvent(),
                        );
                        addUserData();
                      } else
                        return null;
                    },
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  backbutton(BuildContext context) {
    return Container(
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
          Get.to(() => SigninPage());
        },
        label: Text(''),
      ),
    );
  }
}
