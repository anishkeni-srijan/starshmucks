import 'package:flutter/material.dart';

import '../model/offers_model.dart';
import '../repo/offers_repo.dart';

class OffersData extends ChangeNotifier {
  late List<Offers> offerdata = [];

  fetchData(context) async {
    offerdata = await getData(context);
    notifyListeners();
  }
}
