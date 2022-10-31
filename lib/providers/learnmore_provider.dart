import 'package:flutter/material.dart';
import '/repo/learnmore_repo.dart';

import '../model/Learnmore_model.dart';

class Learnmore extends ChangeNotifier {
  late List<LearnMore> learnmore = [];

  fetchData(context) async {
    learnmore = await learnmoredata(context);
    notifyListeners();
  }
}
