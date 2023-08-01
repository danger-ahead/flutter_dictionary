import 'package:flutter/material.dart';
import 'package:flutter_dictionary/constants/strings.dart';
import 'package:flutter_dictionary/widgets/cached_net_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                "Dictionary",
                style: GoogleFonts.poiretOne(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ), //Text
          Card(
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse(StringConstants.projectRepo),
                        webViewConfiguration: WebViewConfiguration(
                          enableJavaScript: true,
                        ));
                  },
                  icon: CachedNetImage(
                      url:
                          'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
                      width: 40,
                      height: 40),
                ),
                IconButton(
                  onPressed: () async {
                    final Uri params = Uri(
                      scheme: 'mailto',
                      path: 'danger.ahead@pm.me',
                      query: 'subject=DICTIONARY Feedback',
                    );
                    await launchUrl(Uri.parse(params.toString()));
                  },
                  icon: CachedNetImage(
                      url:
                          'https://upload.wikimedia.org/wikipedia/commons/3/33/647403-email-128.png',
                      width: 40,
                      height: 40),
                ),
                IconButton(
                  onPressed: () async {
                    await launchUrl(
                      Uri.parse(StringConstants.developerTelegram),
                    );
                  },
                  icon: CachedNetImage(
                      url:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Telegram_logo.svg/240px-Telegram_logo.svg.png',
                      width: 40,
                      height: 40),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
