class OrderHistoryModel {

  late String? qty;

  late String? id;
  OrderHistoryModel({

    required this.qty,
    required this.id,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        qty: json["qty"],
        id: json["id"],
      );
  Map<String, dynamic> toMap() => {

        "qty": qty,
        "id": id,
      };
}
