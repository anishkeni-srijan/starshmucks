import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_events.dart';
import 'bloc/login_states.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final pcontroller = TextEditingController();
  final ucontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: getappbar(),
        backgroundColor: Colors.white,
        body:  SingleChildScrollView(
          child:Center(
            child: Column(children: <Widget>[
              getlogo(context),
             Padding(
               padding: const EdgeInsets.only(top: 80.0, left: 48,),
               child: Align(
                       alignment: Alignment.centerLeft,
                     child: AutoSizeText('Log In.', style: TextStyle(color: HexColor("#036635")), minFontSize: 30,)),
             ),

              SizedBox(
                height: 20,
              ),
              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                //checking if There's an error in Loginstate
                if (state is LoginErrorState) {
                  return Text(
                    state.errormessage,
                    style: TextStyle(color: HexColor("#036635")),
                  );
                }
                //if the login is valid
                else {
                  return Container();
                }
              }),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                ),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black), //<-- SEE HERE
                  controller: ucontroller,
                  onChanged: (value) {
                    BlocProvider.of<LoginBloc>(context).add(
                        LogInTextChangedEvent(
                            ucontroller.text, pcontroller.text));
                  },

                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                      labelText: 'Username',
                      labelStyle: TextStyle(color: HexColor("#036635")),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: HexColor("#036635"), width: 2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                             BorderSide(color: HexColor("#036635"), width: 2),
                      )),
                ),
              ),

              const SizedBox(height: 20),
              //password
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: pcontroller,
                  onChanged: (value) {
                    BlocProvider.of<LoginBloc>(context).add(
                        LogInTextChangedEvent(
                            ucontroller.text, pcontroller.text));
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: HexColor("#036635")),

                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                             BorderSide(color: HexColor("#036635"),width: 2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                           BorderSide(color: HexColor("#036635"),width: 2),
                      )),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(18),
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: HexColor("#036635")),
                ),
              ),
              //submit button
              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: (state is LoginValidState)
                        ? MaterialStateProperty.all<Color>(Colors.white)
                        : MaterialStateProperty.all<Color>(HexColor("#036635")),
                    foregroundColor:
                    (state is LoginValidState)
                        ? MaterialStateProperty.all<Color>(HexColor("#036635"))
                        : MaterialStateProperty.all<Color>(Colors.white),

                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: BorderSide(color: HexColor("#036635"),width: 2),
                        borderRadius: BorderRadius.circular(10))),
                  ),
                  onPressed: () {
                    if (state is LoginValidState) {
                      BlocProvider.of<LoginBloc>(context).add(
                          LoginSumittedEvent(
                              ucontroller.text, pcontroller.text));
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                );
              }),

              Container(
                padding: const EdgeInsets.all(18),
                child:  Text('New User? Sign Up',
                    style: TextStyle(color: HexColor("#036635")),
              )
              )
            ]
              ),
          ),
        ),
    );
  }
}

getappbar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

getlogo(context) {
  return Container(
        transform: Matrix4.translationValues(0, 40, 0),
        child: Image( image: AssetImage('images/shmucks.png',), width:200, ),
      );
}



