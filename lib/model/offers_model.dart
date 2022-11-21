class Offer{
  late int id;
  late String tag;
  late String price;
  late String image;
  late String title;
  late String rating;
  late String desc;
  late String category;

  Offer({
    required this.id,
    required this.tag,
    required this.title,
    required this.price,
    required this.image,
    required this.rating,
    required this.desc,
    required this.category,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
        image: json['image'],
        tag: json['tag'],
        title: json['title'],
        price: json['price'],
        desc: json['desc'],
        rating: json['rating'],
        category:json['category'],
        id: json['id']

    );
  }

  Map<String, Object?> toMap() => { "id": id,
  "title": title,
  "desc": desc,
  "tag":tag,
  "image": image,
  "rating": rating,
  "price": price,
  "category":category,
  };



}
