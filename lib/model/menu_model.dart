class Menu {
  String title;
  String price;
  String description;
  String image;
  String rating;
  int id;
  String category;
  Menu({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.id,
    required this.rating,
    required this.category,
  });



  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    title: json["title"],
    price: json["price"],
    description: json["description"],
    image: json["image"],
    id: json["id"],
    rating: json["rating"],
      category: json['category']
  );
  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "rating": rating,
    "price": price,
    "category":category,
  };


}





