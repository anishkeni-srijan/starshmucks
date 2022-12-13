import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/learnmore_model.dart';

Future<List<LearnMoreModel>> LearnMoreModeldata(context) async {
  List<LearnMoreModel> LearnMoreModeldataModel = [];
  final String response =
      await DefaultAssetBundle.of(context).loadString("json/learnmore.json");
  final responseData = jsonDecode(response);
  for (var i = 0; i < responseData.length; i++) {
    LearnMoreModel prods = LearnMoreModel.fromJson(responseData[i]);
    LearnMoreModeldataModel.add(prods);
  }
  return LearnMoreModeldataModel;
}
