import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../boxes.dart';
import '../model/user_model.dart';
import 'bloc/editdetails_bloc.dart';
import 'bloc/editdetails_events.dart';
import 'bloc/editdetails_states.dart';
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}


final picker = ImagePicker();

class _EditProfileState extends State<EditProfile> {
 File? imagefile;
  final ImagePicker picker = ImagePicker();
  late String obtainedemail;
  late String obtainedphone;
  late String obtainedname;
  late int obtainedkey;

  getuserkey() async {
    final keypref = await SharedPreferences.getInstance();
    userkey = keypref.getInt('userkey')!;
    setState(() {});
    print(userkey);
    return userkey;
  }

  @override
  var userkey;
  void initState() {
    getuserkey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#175244"),
      body: ValueListenableBuilder<Box<UserData>>(
        valueListenable: Boxes.getUserData().listenable(),
        builder: (context, box, _) {
          final data = box.values.toList().cast<UserData>();
          final econtroller = TextEditingController(text: data[userkey].email);
          final ncontroller = TextEditingController(text: data[userkey].name);
          final phcontroller = TextEditingController(text: data[userkey].phone);
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                   showModalBottomSheet(context: context, builder: (context)=>showSelectionDialog());
                  },
                  child: Stack(
                    children: [

                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: imagefile == null ? DecorationImage(
                             image: AssetImage('images/profile1.jpg') )// set a placeholder image when no photo is set
                                :DecorationImage(image: FileImage(File(imagefile!.path)),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(75.0),
                          ),
                          border: Border.all(
                            color: Colors.white,
                            width: 4.0,
                          ),
                        ),
                       ),
                      Container(transform: Matrix4.translationValues(60, 150,0) ,child: Icon(Icons.add_a_photo, color: Colors.white,)),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    data[userkey].name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      BlocBuilder<EditdetailsBloc, EditdetailsState>(
                        builder: (context, state) {
                          //checking if There's an error in Loginstate
                          if (state is EditdetailsErrorState) {
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
                      // DividerForTiles(),
                      Row(
                        children: [
                          EditableField(
                            econtroller: econtroller,
                            lbltxt: 'Email',
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          EditableField(
                            econtroller: phcontroller,
                            lbltxt: 'Phone',
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          EditableField(
                            econtroller: ncontroller,
                            lbltxt: 'Name',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            HexColor("#175244"),
                          ),
                        ),
                        onPressed: () {
                          BlocProvider.of<EditdetailsBloc>(context).add(
                            EditdetailsemailChangedEvent(
                              econtroller.text,
                            ),
                          );
                          BlocProvider.of<EditdetailsBloc>(context).add(
                            EditdetailsNameChangedEvent(
                              ncontroller.text,
                            ),
                          );
                          BlocProvider.of<EditdetailsBloc>(context).add(
                            EditdetailsNumberChangedEvent(
                              phcontroller.text,
                            ),
                          );
                          data[userkey].name = ncontroller.text;
                          data[userkey].email = econtroller.text;
                          data[userkey].phone = phcontroller.text;
                          box.putAt(userkey, data[userkey]);
                          setState(() {});
                        },
                        child: Text('UPDATE'),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  showSelectionDialog() {
    return Container(
      height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                TextButton.icon(onPressed: (){ takepicture(ImageSource.camera);}, icon: Icon(Icons.camera_alt_outlined, color: HexColor("#175244"),),label: Text('Click a picture now',  style: TextStyle(color: HexColor("#175244")),),),
                TextButton.icon(onPressed: (){
                  takepicture(ImageSource.gallery);
                }, icon: Icon(Icons.image, color: HexColor("#175244")), label: Text('Choose one from galary', style: TextStyle(color: HexColor("#175244")),),)
              ]),
            );
  }
  takepicture(ImageSource source)async{
    final pickedfile = await picker.pickImage(source: source);
    setState(() {
      imagefile = File(pickedfile!.path);
    });

  }
}



class EditableField extends StatelessWidget {
  const EditableField({
    Key? key,
    required this.econtroller,
    required this.lbltxt,
  }) : super(key: key);

  final TextEditingController econtroller;
  final String lbltxt;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        autocorrect: false,
        style: const TextStyle(
          color: Colors.black,
        ),
        controller: econtroller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: lbltxt,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
