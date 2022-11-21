//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
//
// import '../model/nowserving_model.dart';
//
// Future<List<NowServe>> nowservingdata(context) async {
//   List<NowServe> NowServedataModel = [];
//   final String response = await DefaultAssetBundle.of(context).loadString("json/nowserve.json");
//   final responseData = jsonDecode(response);
//   for(var i = 0; i< responseData.length; i++) {
//     NowServe prods = NowServe.fromJson(responseData[i]);
//     NowServedataModel.add(prods);
//   }
//   return NowServedataModel;
//
//
// }