class CartModel {
  int id;

  CartModel({required this.id});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
