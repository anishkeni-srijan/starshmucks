import 'package:flutter/material.dart';

import '../model/learnmore_model.dart';
import '../repo/learnmore_repo.dart';


class Learnmore extends ChangeNotifier {
  late List<LearnMoreModel> learnmore = [];

  fetchData(context) async {
    learnmore = await LearnMoreModeldata(context);
    notifyListeners();
  }
}
