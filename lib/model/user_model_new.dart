class UserModel {
  //int id;
  String name;
  String email;
  String phone;
  String dob;
  String password;
  String tnc;
  double rewards;
  UserModel({
    // required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.password,
    required this.tnc,
    required this.rewards,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        dob: json["dob"],
        password: json["password"],
        tnc: json["tnc"],
        rewards: json["rewards"],
        // id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "phone": phone,
        "dob": dob,
        "password": password,
        "tnc": tnc,
        "rewards": rewards,
        // "id": id,
      };
}
