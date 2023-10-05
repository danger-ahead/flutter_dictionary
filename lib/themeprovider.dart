import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final themeProvider = ChangeNotifierProvider((ref) => themeNotifier());

class themeNotifier extends ChangeNotifier {
  ThemeMode _value = ThemeMode.light;
  ThemeMode get value => _value;

  void setDark() {
    _value = ThemeMode.dark;
    Fluttertoast.showToast(
        msg: "Theme Set to Dark Mode",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
    notifyListeners();
  }

  void setLight() {
    _value = ThemeMode.light;
    Fluttertoast.showToast(
        msg: "Theme Set to Light Mode",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
    notifyListeners();
  }

  void setSystem() {
    _value = ThemeMode.system;
    Fluttertoast.showToast(
        msg: "Theme Set to System Mode",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
    notifyListeners();
  }
}
