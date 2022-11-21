import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 1)
class CartData extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String price;

  @HiveField(2)
  late int qty;

  @HiveField(3)
  late bool isInCart = false;

  @HiveField(4)
  late String image;

  @HiveField(5)
  late double ttlPrice;

  @HiveField(6)
  late int id;
}





