import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProvider with ChangeNotifier {
  Locale _appLocale;
  LocalProvider() {
    syncData();
  }

  Future syncData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _appLocale = preferences.getString('language_code') != null
        ? Locale(preferences.getString('language_code'))
        : Locale('ar');
    notifyListeners();
  }

  Locale get appLocal => _appLocale ?? _appLocale;

  void changeLanguage(Locale type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (type == Locale("ar")) {
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', '');
      _appLocale = Locale(prefs.getString('language_code'));
    } else {
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
      _appLocale = Locale(prefs.getString('language_code'));
    }
    notifyListeners();
  }
}
