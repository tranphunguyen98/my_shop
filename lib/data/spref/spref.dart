import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPref {
  static final SPref instance = SPref._internal();
  SPref._internal() {
    debugPrint("SPref created");
  }

  Future set(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  dynamic get(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
