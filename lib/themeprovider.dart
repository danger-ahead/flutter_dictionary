import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod/riverpod.dart';

// final themeprovider = ChangeNotifierProvider((ref) => ThemeSetter());

final themeProvider = ChangeNotifierProvider((ref) => themeNotifier());

class themeNotifier extends ChangeNotifier {
  ThemeMode _value = ThemeMode.light;
  ThemeMode get value => _value;

  void setDark() {
    _value = ThemeMode.dark;
    notifyListeners();
  }
  void setLight() {
    _value = ThemeMode.light;
    notifyListeners();
  }
  void setSystem() {
    _value = ThemeMode.system;
    notifyListeners();
  }
}



// class ThemeSetter extends ChangeNotifier {
//   ThemeMode _value = ThemeMode.light;
//   ThemeMode get currentTheme => _value;

//   void setDark() {
//     _value = ThemeMode.dark;
//     notifyListeners();
//   }
//   void setLight() {
//     _value = ThemeMode.light;
//     notifyListeners();
//   }
// }
