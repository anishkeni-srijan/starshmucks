// import 'dart:convert';
//
// import 'package:flutter/material.dart';
//
// import '../model/offers_model.dart';
//
// Future<List<Offers>> getData(context) async {
//   List<Offers> offersdataModel = [];
//   final String response =
//       await DefaultAssetBundle.of(context).loadString("json/offers.json");
//   final responseData = jsonDecode(response);
//   for (var i = 0; i < responseData.length; i++) {
//     Offers prods = Offers.fromJson(responseData[i]);
//     offersdataModel.add(prods);
//   }
//   return offersdataModel;
// }
