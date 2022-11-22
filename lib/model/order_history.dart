class OrderHistoryModel {
  late String title;
  late String price;
  late int qty;
  late bool isInCart = false;
  late String image;
  late double ttlPrice;
  late int id;
  OrderHistoryModel({
    required this.title,
    required this.price,
    required this.qty,
    required this.isInCart,
    required this.image,
    required this.ttlPrice,
    required this.id,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        title: json["title"],
        price: json["price"],
        qty: json["qty"],
        isInCart: json["isInCart"],
        image: json["image"],
        ttlPrice: json["ttlPrice"],
        id: json["id"],
      );
  Map<String, dynamic> toMap() => {
        "title": title,
        "price": price,
        "qty": qty,
        "isInCart": isInCart,
        "image": image,
        "ttlPrice": ttlPrice,
        "id": id,
      };
}
