class MenuModel {
  String title;
  String price;
  String description;
  String image;
  String rating;
  String tag;
  int id;
  late int qty;
  String category;

  MenuModel({
    required this.title,
    required this.tag,
    required this.price,
    required this.description,
    required this.image,
    required this.id,
    required this.rating,
    required this.category,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
      title: json["title"],
      tag: json["tag"],
      price: json["price"],
      description: json["description"],
      image: json["image"],
      id: json["id"],
      rating: json["rating"],
      category: json['category']);
  Map<String, dynamic> toMap() => {
        "id": id,
        "tag": tag,
        "title": title,
        "description": description,
        "image": image,
        "rating": rating,
        "price": price,
        "category": category,
      };
}
