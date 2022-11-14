import 'package:hive/hive.dart';
import 'dart:io';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String email;

  @HiveField(2)
  late String phone;

  @HiveField(3)
  late String dob;

  @HiveField(4)
  late String password;

  @HiveField(5)
  late bool tnc = false;

  @HiveField(6)
  late bool isactive = false;

  @HiveField(7)
  late List<Map<dynamic, dynamic>> address = [];

  @HiveField(8)
  File? profileimage;


}
