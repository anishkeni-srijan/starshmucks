class Menu {
  Menu({
    required this.title,
    required this.category,
    required this.description,
    required this.image,
    required this.id,
  });

  String title;
  String category;
  String description;
  String image;
  int id;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    title: json["title"],
    category: json["category"],
    description: json["description"],
    image: json["image"],
    id: json["id"],
  );
}
