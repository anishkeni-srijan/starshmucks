class LearnMore {
  late String image;
  late String title;
  late String tag;
  late String desc;

  LearnMore({
    required this.title,
    required this.tag,
    required this.image,
    required this.desc,
  });

  factory LearnMore.fromJson(Map<String, dynamic> json) => LearnMore(
      title: json['title'],
      image: json['image'],
      desc: json['desc'],
      tag: json['tag']);
}
