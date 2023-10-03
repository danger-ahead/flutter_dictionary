import 'package:flutter/material.dart';
import 'package:flutter_dictionary/constants/strings.dart';
import 'package:flutter_dictionary/themes/dark_theme.dart';
import 'package:flutter_dictionary/themes/light_theme.dart';
import 'package:flutter_dictionary/ui/random_word.dart';
import 'package:flutter_dictionary/ui/results.dart';
import 'package:flutter_dictionary/ui/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SafeArea(child: ProviderScope(child: MyApp())));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  bool _isDark = false;

  void _changeTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: _isDark ? lightTheme : darkTheme,
      initialRoute: StringConstants.homeRoute,
      routes: {
        StringConstants.homeRoute: (context) => Home(changeTheme: _changeTheme),
        StringConstants.resultRoute: (context) => Results(),
        StringConstants.randomRoute: (context) => RandomResults(),
      },
    );
  }
}
