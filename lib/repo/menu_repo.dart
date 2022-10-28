
import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/menu_model.dart';


Future<List<Menu>> getcakedata(context) async {
  List<Menu> cakeMenuData = [];
  final String cakeresponse = await DefaultAssetBundle.of(context).loadString("json/menu.json");
  final cakeresponseData = jsonDecode(cakeresponse);
  for(var i = 0; i< cakeresponseData[0]['cake'].length; i++) {
    Menu prods = Menu.fromJson(cakeresponseData[0]["cake"][i]);
    cakeMenuData.add(prods);
  }

  return cakeMenuData;
}
Future<List<Menu>> getcoffeedata(context) async {
  List<Menu> coffeeMenuData = [];
  final String coffeeresponse = await DefaultAssetBundle.of(context).loadString("json/menu.json");
  final coffeeresponseData = jsonDecode(coffeeresponse);
  for(var i = 0; i< coffeeresponseData[0]['coffee'].length; i++) {
    Menu prods = Menu.fromJson(coffeeresponseData[0]["coffee"][i]);
    coffeeMenuData.add(prods);
  }
  return coffeeMenuData;
}
Future<List<Menu>> getsmoothiedata(context) async {
  List<Menu> smoothieMenuData = [];
  final String smoothieresponse = await DefaultAssetBundle.of(context).loadString("json/menu.json");
  final smoothieresponseData = jsonDecode(smoothieresponse);
  for(var i = 0; i< smoothieresponseData[0]["smoothie"].length; i++) {
    Menu prods = Menu.fromJson(smoothieresponseData[0]["smoothie"][i]);
    smoothieMenuData.add(prods);
  }
  return smoothieMenuData;
}