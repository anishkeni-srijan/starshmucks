class CartModel {
  int id;
  int qty;
  double cartttl;

  CartModel({
    required this.id,
    required this.qty,
    required this.cartttl,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        qty: json["qty"],
        cartttl: json["cartttl"]
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "qty": qty,
        "cartttl": cartttl,
      };
}
