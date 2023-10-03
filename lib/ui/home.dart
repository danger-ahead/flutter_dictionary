import 'package:flutter/material.dart';
import 'package:flutter_dictionary/constants/strings.dart';
import 'package:flutter_dictionary/providers.dart';
import 'package:flutter_dictionary/ui/components/home/previous_words_view.dart';
import 'package:flutter_dictionary/ui/components/home/about_view.dart';
import 'package:flutter_dictionary/ui/components/home/primary_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final navIndex = ref.watch(navController);
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
