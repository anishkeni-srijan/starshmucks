
import 'package:flutter/material.dart';

import '../model/nowserving_model.dart';

import '../repo/nowserving_repo.dart';



class NowServing extends ChangeNotifier{

  late List<NowServe> nowdata= [];

  fetchData(context) async{

    notifyListeners();
  }

}


