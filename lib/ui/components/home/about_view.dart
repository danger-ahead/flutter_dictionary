import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dictionary/constants/strings.dart';
import 'package:flutter_dictionary/providers.dart';
import 'package:flutter_dictionary/widgets/cached_net_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
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
            )
          ],
        ),
      );
    });
  }
}
