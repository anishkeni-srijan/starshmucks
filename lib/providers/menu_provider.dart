import 'package:flutter/material.dart';
import '../model/menu_model.dart';
import '../order/order_page.dart';

class Menudata extends ChangeNotifier {
  late List<Menu> cakemenudata = [];
  late List<Menu> coffeemenudata = [];
  late List<Menu> smoothiemenudata = [];

  cakefetchData(context) async {
    print(cakemenudata.length);
    notifyListeners();
  }

  coffeefetchData(context) async {
    print(cakemenudata.length);
    notifyListeners();
  }

  smoothiefetchData(context) async {
    print(cakemenudata.length);
    notifyListeners();
  }
}
