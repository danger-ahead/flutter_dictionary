import 'package:flutter/material.dart';
import 'package:flutter_dictionary/constants/strings.dart';
import 'package:flutter_dictionary/themeprovider.dart';
import 'package:flutter_dictionary/ui/random_word.dart';
import 'package:flutter_dictionary/ui/results.dart';
import 'package:flutter_dictionary/ui/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SafeArea(child: ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final themeNotifier = ref.watch(themeProvider);
      final themeColor = themeNotifier.value;

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: themeColor,
        // ThemeData(useMaterial3: true,),
        
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeColor,
        initialRoute: StringConstants.homeRoute,
        routes: {
          StringConstants.homeRoute: (context) => Home(),
          StringConstants.resultRoute: (context) => Results(),
          StringConstants.randomRoute: (context) => RandomResults(),
        },
      );
    });
  }
}
