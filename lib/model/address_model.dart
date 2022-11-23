class AddressModel {
  int addressID;
  int userID;
  String address;
  AddressModel({
    required this.addressID,
    required this.userID,
    required this.address,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        addressID: json["addressID"],
        userID: json["userID"],
        address: json["address"],
      );

  Map<String, dynamic> toMap() => {
        "addressID": addressID,
        "userID": userID,
        "address": address,
      };
}
