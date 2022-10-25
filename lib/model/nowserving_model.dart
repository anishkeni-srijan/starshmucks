import 'package:flutter/material.dart';


class NowServe{
  late String id;
  late String tag;
  late String price;
  late String image;
  late String title;
  late String rating;
  late String desc;
  

  NowServe({
    required this.id,
    required this.tag,
    required this.title,
    required this.price,
    required this.image,
    required this.rating,
    required this.desc,
    
  });


  factory NowServe.fromJson(Map<String,dynamic> json){
    return NowServe(id: json['id'],title: json['title'], price: json['price'], rating: json['rating'], image: json['image'], desc: json['desc'], tag: json['tag'], );
  }


}




