import 'package:hive/hive.dart';

import 'model/user_model.dart';

class Boxes {
  static Box<UserDataModel> getUserData() =>
      Hive.box<UserDataModel>('signupdata');
}
