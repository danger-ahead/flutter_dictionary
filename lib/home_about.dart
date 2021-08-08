import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_dictionary/widgets/CachedNetImage.dart';
import 'package:flutter_dictionary/widgets/NoNet.dart';
import 'package:flutter_dictionary/PreviousWords.dart';
import 'package:flutter_dictionary/random_results.dart';
import 'package:google_fonts/google_fonts.dart';
import 'results.dart';
import 'package:url_launcher/url_launcher.dart';

dynamic layoutHomeAbout(int selected, BuildContext context) {
  TextEditingController _word = TextEditingController();
  String choice = 'English (US)';

  callSetState(String _choice) {
    choice = _choice;
  }

  List<Widget> widgetArray = [
    LayoutBuilder(
      builder: (context, viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: viewportConstraints.copyWith(
              minHeight: viewportConstraints.maxHeight,
              maxHeight: double.infinity,
            ),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRect(
                  child: Image.asset(
                    "images/icon.png",
                    scale: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 30.0),
                  child: TextField(
                    controller: _word,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        color: Colors.green,
                        icon: Icon(Icons.close),
                        onPressed: () {
                          _word.text = '';
                        },
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: DropdownButton<String>(
                          dropdownColor: Colors.yellow[50],
                          underline: SizedBox(),
                          value: choice,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            callSetState(newValue!);
                          },
                          items: <String>[
                            'English (US)',
                            'English (UK)',
                            'Spanish',
                            'French',
                            'Russian',
                            'German',
                            'Italian',
                            'Hindi',
                            'Japanese',
                            'Arabic',
                            'Korean'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.green, width: 8.0),
                      ),
                      filled: true,
                      fillColor: Colors.yellow[50],
                      hintStyle: TextStyle(color: Colors.green),
                      hintText: 'Enter a word',
                    ),
                  ),
                ),
                Center(
                  //https://stackoverflow.com/a/68510802/10951873
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 65, height: 65),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<CircleBorder>(
                                CircleBorder())),
                        child: Icon(Icons.search),
                        onPressed: () async {
                          detectNetStatus(context);
                          String word = _word.text;
                          _word.text = '';
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return word == ''
                                ? RandomResults()
                                : Results(word, choice);
                          }));
                        }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
    ListView(
      children: [
        Card(
          color: Colors.yellow[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          shadowColor: Colors.black,
          elevation: 4,
          child: TextButton(
              child: Text(
                "Previously searched words",
                textScaleFactor: 1.1,
                style: GoogleFonts.michroma(),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PreviousWords();
                }));
              }),
        ),
        Card(
          color: Colors.yellow[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          shadowColor: Colors.black,
          elevation: 4,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: customNetImage(
                    'https://lh3.googleusercontent.com/ogw/ADea4I7zbwFbA0doDuapQoIaYRU04bJ8o6ObrmyEkRmE8Ys=s300-c-mo',
                    150.0,
                    150.0),
              ),
              ListTile(
                //ClipRect
                title: Text(
                  "Hi, I'm Shourya!\nDICTIONARY is my first flutter project.",
                  textScaleFactor: 1.9,
                  style: GoogleFonts.poiretOne(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
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
                    icon: customNetImage(
                        'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
                        80,
                        80),
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
                      await canLaunch(url)
                          ? await launch(url)
                          : throw 'Could not launch $url';
                    },
                    icon: customNetImage(
                        'https://upload.wikimedia.org/wikipedia/commons/3/33/647403-email-128.png',
                        80,
                        80),
                  ),
                  IconButton(
                    onPressed: () async {
                      await canLaunch(_telegram)
                          ? await launch(
                              _telegram,
                            )
                          : throw 'Could not launch $_telegram';
                    },
                    icon: customNetImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Telegram_logo.svg/240px-Telegram_logo.svg.png',
                        80,
                        80),
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
