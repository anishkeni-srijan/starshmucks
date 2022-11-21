// import 'package:hive/hive.dart';
//
// part 'cart_model.g.dart';
//
// @HiveType(typeId: 1)
// class CartData extends HiveObject {
//   @HiveField(0)
//   late String title;
//
//   @HiveField(1)
//   late String price;
//
//   @HiveField(2)
//   late int qty;
//
//   @HiveField(3)
//   late bool isInCart = false;
//
//   @HiveField(4)
//   late String image;
//
//   @HiveField(5)
//   late double ttlPrice;
//
//   @HiveField(6)
//   late int id;
// }


class Cart {
  String title;
  String price;
  String image;
  int id;
  Cart({
    required this.title,
    required this.price,
    required this.image,
    required this.id,
  });



  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      title: json["title"],
      price: json["price"],
      image: json["image"],
      id: json["id"],
  );
  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "image": image,
    "price": price,
  };


}

