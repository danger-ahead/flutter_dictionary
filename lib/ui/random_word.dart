import 'package:flutter/material.dart';
import 'package:flutter_dictionary/providers.dart';
import 'package:flutter_dictionary/themeprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

class RandomResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final appTheme = ref.watch(themeProvider);
      var sysTheme = MediaQuery.platformBrightnessOf(context);
      return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Icon(Icons.arrow_back_ios),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "Here's a word for you!",
                style: GoogleFonts.concertOne(),
              )),
          body: ref.watch(randomWordsFutureProvider).when(
                data: ((data) => data.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Share.share("Here's a word for you, \"" +
                                data[0].word +
                                "\".\n\nIt means \"" +
                                data[0].definition +
                                "\".\n\n" +
                                "Wondering about the pronunciation? It's \"" +
                                data[0].pronunciation +
                                "\".");
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[0].word,
                                style: GoogleFonts.poppins(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Meaning: ",
                                  children: [
                                    TextSpan(
                                      text: data[0].definition,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Pronunciation: ",
                                  children: [
                                    TextSpan(
                                      text: data[0].pronunciation,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )),
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                    child: Column(
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height / 10),
                    appTheme.value == ThemeMode.dark
                        ? Lottie.asset('animation/ErrorAnimationDark.json')
                        : appTheme.value == ThemeMode.light
                            ? Lottie.asset('animation/ErrorAnimationLight.json')
                            : sysTheme == Brightness.light
                                ? Lottie.asset(
                                    'animation/ErrorAnimationLight.json')
                                : Lottie.asset(
                                    'animation/ErrorAnimationDark.json'),
                    SizedBox(height: MediaQuery.sizeOf(context).height / 30),
                    Text("Sorry! Something Went Wrong :(",
                        style: GoogleFonts.poppins(fontSize: 22))
                  ],
                )),
              ));
    });
  }
}
