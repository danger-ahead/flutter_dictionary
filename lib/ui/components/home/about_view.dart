import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dictionary/constants/strings.dart';
import 'package:flutter_dictionary/providers.dart';
import 'package:flutter_dictionary/widgets/cached_net_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dictionary/themeprovider.dart';

class AboutView extends StatefulWidget {
  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  String dropdownValue = 'System';
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      void _setDark(BuildContext context) {
        ref.read(themeProvider).setDark();
      }

      void _setLight(BuildContext context) {
        ref.read(themeProvider).setLight();
      }

       void _setSystem(BuildContext context) {
        ref.read(themeProvider).setSystem();
      }

      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dictionary",
                        style: GoogleFonts.poppins(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ref.watch(packageInfoFutureProvider).when(
                          data: (data) => Text.rich(
                                TextSpan(
                                  text: 'Version: ',
                                  children: [
                                    TextSpan(
                                      text:
                                          '${data.version}+${data.buildNumber}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          error: (error, stackTrace) => Center(
                                child: Text(
                                  "Error :(",
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                          loading: () => Center(
                                child: CircularProgressIndicator(),
                              )),
                      Text.rich(
                        TextSpan(
                          text: 'Maintained by: ',
                          children: [
                            TextSpan(
                              text: '@danger-ahead',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => launchUrl(Uri.parse(
                                    StringConstants.developerWebsite)),
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Settings",
                style: GoogleFonts.poppins(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Text(
                    "Theme:",
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  items: <String>['System', 'Light', 'Dark']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue == 'System') {
                      setState(() {
                        dropdownValue = newValue!;
                        _setSystem(context);

                      });
                    }
                    if (newValue == 'Light') {
                      setState(() {
                        dropdownValue = newValue!;
                        _setLight(context);
                      });
                    }
                    if (newValue == 'Dark') {
                      setState(() {
                        dropdownValue = newValue!;
                        _setDark(context);
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
