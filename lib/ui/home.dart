import 'package:flutter/material.dart';
import 'package:flutter_dictionary/constants/strings.dart';
import 'package:flutter_dictionary/ui/components/home/previous_words_view.dart';
import 'package:flutter_dictionary/ui/components/home/about_view.dart';
import 'package:flutter_dictionary/ui/components/home/primary_view.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
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
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                ),
                Tab(
                  icon: Icon(Icons.history),
                ),
                Tab(
                  icon: Icon(Icons.article),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [PrimaryView(), PreviousWordsView(), AboutView()],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, StringConstants.randomRoute);
            },
            child: Icon(Icons.question_mark),
          ),
        ));
  }
}
