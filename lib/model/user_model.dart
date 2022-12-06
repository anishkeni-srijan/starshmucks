class UserModel {
  //int id;
  String name;
  String email;
  String phone;
  String dob;
  String password;
  String tnc;
  double rewards;
  String tier;
  String image;

  UserModel({
      required this.tier,
      required this.name,
      required this.email,
      required this.phone,
      required this.dob,
      required this.password,
      required this.tnc,
      required this.rewards,
      required this.image
      });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        tier:json["tier"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        dob: json["dob"],
        password: json["password"],
        tnc: json["tnc"],
        rewards: json["rewards"], image: json["image"],
        // id: json["id"],
      );

  Map<String, dynamic> toMap() => {
         "tier":tier,
        "name": name,
        "email": email,
        "phone": phone,
        "dob": dob,
        "password": password,
        "tnc": tnc,
        "rewards": rewards,
        "image": image,
      };
}
