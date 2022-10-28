
import 'package:flutter/material.dart';
import 'package:starshmucks/repo/learnmore_repo.dart';

import '../model/Learnmore_model.dart';
import '../model/menu_model.dart';
import '../repo/menu_repo.dart';



class Menudata extends ChangeNotifier{

  late List<Menu> menudata = [];

  fetchData(context) async{
    menudata = await getmenudata(context);
    notifyListeners();
  }

}

