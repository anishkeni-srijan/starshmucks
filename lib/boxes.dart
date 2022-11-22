import 'package:hive/hive.dart';

import 'model/user_model.dart';

class Boxes {
  static Box<UserData> getUserData() => Hive.box<UserData>('signupdata');
}
