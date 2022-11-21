import 'package:flutter/material.dart';

import '../model/offers_model.dart';
import '../repo/offers_repo.dart';

class OffersData extends ChangeNotifier {
  late List<Offer> offerdata = [];
  fetchData(context) async {
    notifyListeners();
  }
}
