class OrderHistoryModel {
  late String? qty;
  late String? id;
  late String? date;
  OrderHistoryModel({
    required this.qty,
    required this.id,
    required this.date,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        qty: json["qty"],
        id: json["id"],
        date: json["date"],
      );
  Map<String, dynamic> toMap() => {
        "qty": qty,
        "id": id,
        "date": date,
      };
}
