class OrderHistoryModel {

  late String? qty;
  late String? rewards;
  late String? id;
  OrderHistoryModel({
    required this.rewards,
    required this.qty,
    required this.id,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        qty: json["qty"],
        rewards: json["rewards"],
        id: json["id"],
      );
  Map<String, dynamic> toMap() => {
        "qty": qty,
        "id": id,
        "rewards":rewards,
      };
}
