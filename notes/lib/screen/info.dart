import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';
import '../util/app_info.dart';

class InfoPage extends StatelessWidget {
  final Future<String> _version = AppInfo.appVersion;

  InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Themes.background,
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.66,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    AppInfo.appInfo1,
                    textAlign: TextAlign.center,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      AppInfo.appInfo2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      AppInfo.appInfo3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: RichText(
                      text: TextSpan(
                        text: 'GitHub repository',
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Themes.red),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(AppInfo.repoURL);
                          },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: RichText(
                      text: TextSpan(
                        text: 'Report a bug',
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Themes.red),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(AppInfo.bugReportLink);
                          },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: FutureBuilder<String>(
                        future: _version,
                        builder: (context, snapshot) {
                          var version = 'retreiving app version...';
                          if (snapshot.hasData) {
                            version = 'v${snapshot.data!}';
                          }
                          if (snapshot.hasError) {
                            version = 'failed to retreive the app version';
                          }
                          return Text(
                            version,
                            style: const TextStyle(fontSize: 10),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
