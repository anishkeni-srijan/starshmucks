import 'package:hive/hive.dart';

import 'model/cart_model.dart';
import 'model/user_model.dart';

class Boxes {
  static Box<UserData> getUserData() => Hive.box<UserData>('signupdata');
  static Box<CartData> getCartData() => Hive.box<CartData>('cartdata');
}
