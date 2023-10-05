import 'package:flutter/material.dart';
import 'package:flutter_dictionary/constants/strings.dart';
import 'package:flutter_dictionary/providers.dart';
import 'package:flutter_dictionary/ui/components/home/previous_words_view.dart';
import 'package:flutter_dictionary/ui/components/home/about_view.dart';
import 'package:flutter_dictionary/ui/components/home/primary_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dictionary/themeprovider.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final navIndex = ref.watch(navController);
      final themeNotifier = ref.watch(themeProvider);
      final themeColor = themeNotifier.value;

      void _setDark(BuildContext context) {
        ref.read(themeProvider).setDark();
      }

      void _setLight(BuildContext context) {
        ref.read(themeProvider).setLight();
      }

       void _setSystem(BuildContext context) {
        ref.read(themeProvider).setSystem();
      }

      return Scaffold(
        appBar: AppBar(
          title: Text(
            "dictionary",
            style: GoogleFonts.concertOne(
              fontSize: 26,
              letterSpacing: 2.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              if(themeColor == ThemeMode.dark){
                _setSystem(context);
              }else if(themeColor == ThemeMode.system){
                _setLight(context);
              }else{
                _setDark(context);
              }
            }, icon: themeColor == ThemeMode.dark ? Icon(Icons.nightlight_round) : themeColor == ThemeMode.light ? Icon(Icons.wb_sunny) : Icon(Icons.auto_awesome)),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.article), label: '')
          ],
          currentIndex: navIndex,
          onTap: (value) {
            ref.read(navController.notifier).update((state) => value);
          },
        ),
        body: <Widget>[
          PrimaryView(),
          PreviousWordsView(),
          AboutView(),
        ][navIndex],
        floatingActionButton: navIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, StringConstants.randomRoute);
                },
                child: Icon(Icons.question_mark),
              )
            : null,
      );
    });
  }
}
