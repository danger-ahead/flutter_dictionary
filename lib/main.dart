import 'package:flutter/material.dart';
import 'package:flutter_dictionary/ui/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(SafeArea(child: ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
