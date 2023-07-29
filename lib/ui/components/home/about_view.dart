import 'package:flutter/material.dart';
import 'package:flutter_dictionary/constants/strings.dart';
import 'package:flutter_dictionary/widgets/CachedNetImage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Dictionary",
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
                      await launchUrl(Uri.parse(StringConstants.projectRepo),
                          webViewConfiguration: WebViewConfiguration(
                            enableJavaScript: true,
                          ));
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
                      await launchUrl(Uri.parse(params.toString()));
                    },
                    icon: customNetImage(
                        'https://upload.wikimedia.org/wikipedia/commons/3/33/647403-email-128.png',
                        80,
                        80),
                  ),
                  IconButton(
                    onPressed: () async {
                      await launchUrl(
                        Uri.parse(StringConstants.developerTelegram),
                      );
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
    );
  }
}
