import 'package:flutter/material.dart';


class Offers{
  late String id;
  late String offer;
  late String price;
  late String image;
  late String title;
  late String rating;
  late String desc;


  Offers({
    required this.id,
    required this.offer,
    required this.title,
    required this.price,
    required this.image,
    required this.rating,
    required this.desc,


  });


  factory Offers.fromJson(Map<String,dynamic> json){
    return Offers(id: json['id'],title: json['title'], price: json['price'], rating: json['rating'], image: json['image'], desc: json['desc'], offer: json['offer'],);
  }


}




