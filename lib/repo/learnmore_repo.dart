
import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/Learnmore_model.dart';

Future<List<LearnMore>> learnmoredata(context) async {
  List<LearnMore> LearnMoredataModel = [];
  final String response = await DefaultAssetBundle.of(context).loadString("json/learnmore.json");
  final responseData = jsonDecode(response);
  for(var i = 0; i< responseData.length; i++) {
    LearnMore prods = LearnMore.fromJson(responseData[i]);
    LearnMoredataModel.add(prods);
  }
  return LearnMoredataModel;


}