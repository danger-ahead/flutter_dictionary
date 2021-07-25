import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_dictionary/PreviousWords.dart';
import 'package:flutter_dictionary/random_results.dart';
import 'package:google_fonts/google_fonts.dart';
import 'results.dart';
import 'package:url_launcher/url_launcher.dart';

dynamic layoutHomeAbout(int selected, BuildContext context) {
  TextEditingController _word = TextEditingController();

  List<Widget> widgetArray = [
    ListView(children: [
      ClipRect(
        child: Image.asset(
          'images/icon.png',
          scale: 2,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: TextField(
          controller: _word,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            helperText: 'Enter a word',
          ),
        ),
      ),
      Row(
        //Row has been used to make the ElevatedButton just large enough to fit the text inside it
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              child: Text(
                "Search",
                style: GoogleFonts.michroma(
                  letterSpacing: 2,
                ),
              ),
              onPressed: () async {
                String word = _word.text;
                _word.text = '';
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return word == '' ? RandomResults() : Results(word);
                }));
              }),
        ],
      ), //Padding
    ]),
    ListView(
      children: [
        Card(
          shadowColor: Colors.black,
          elevation: 4,
          child: TextButton(
              child: Text(
                "Previously searched words",
                style: GoogleFonts.michroma(),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PreviousWords();
                }));
              }),
        ),
        Card(
          shadowColor: Colors.black,
          elevation: 4,
          child: Column(
            children: [
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: ClipRect(
                      child: Image.network(
                          'https://avatars.githubusercontent.com/u/55531939?v=4')),
                ),
                //ClipRect
                title: Text(
                  "Hi, I'm Shourya!\nDICTIONARY is my first flutter project.",
                  style: GoogleFonts.poiretOne(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )),
                ), //Text
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () async {
                      await canLaunch(_github)
                          ? await launch(_github,
                              forceWebView: true,
                              enableJavaScript: true,
                              enableDomStorage: true)
                          : throw 'Could not launch $_github';
                    },
                    icon: Image.network(
                      'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
                      scale: 15,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final Uri params = Uri(
                        scheme: 'mailto',
                        path: 'danger.ahead@pm.me',
                        query:
                            'subject=DICTIONARY Feedback', //add subject and body here
                      );

                      var url = params.toString();
                      await canLaunch(url) ?
                        await launch(url) : throw 'Could not launch $url';
                    },
                    icon: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Email_Logo_PNG.png/640px-Email_Logo_PNG.png',
                      scale: 25,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await canLaunch(_telegram)
                          ? await launch(_telegram,) : throw 'Could not launch $_telegram';
                    },
                    icon: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Telegram_logo.svg/240px-Telegram_logo.svg.png',
                      scale: 8,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    )
  ];
  return widgetArray[selected];
}

const _github = 'https://github.com/danger-ahead/flutter_dictionary';
String _telegram = "https://telegram.me/danger_ahead";
