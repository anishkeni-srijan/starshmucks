
import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/menu_model.dart';


Future<List<Menu>> getmenudata(context) async {
  List<Menu> MenuData = [];
  final String response = await DefaultAssetBundle.of(context).loadString("json/menu.json");
  final responseData = jsonDecode(response);
  for(var i = 0; i< responseData.length; i++) {
    Menu prods = Menu.fromJson(responseData[i]);
    MenuData.add(prods);
  }
  return MenuData;
}