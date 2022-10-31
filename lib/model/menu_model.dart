class Menu {
  Menu({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.id,
    required this.rating,
  });

  String title;
  String price;
  String description;
  String image;
  String rating;
  int id;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    title: json["title"],
    price: json["price"],
    description: json["description"],
    image: json["image"],
    id: json["id"],
    rating: json["rating"]
  );
}
