import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:notes/theme/themes.dart';
import 'package:notes/widget/theme_tile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';
import '../util/app_info.dart';

class SettingsPage extends StatelessWidget {
  final Future<String> _version = AppInfo.appVersion;

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppTheme>(
        builder: (context, appTheme, child) => Stack(
          children: [
            appTheme.theme.background,
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: appTheme.theme.semiTransparentBG,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Select an App Theme:',
                              style: TextStyle(
                                  color: appTheme.theme.secondaryColor),
                            )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: AppThemeData.allThemes.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () =>
                            AppTheme().setTheme(AppThemeData.allThemes[index]),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10),
                          child: SizedBox(
                            height: 50,
                            child: ThemeTile(AppThemeData.allThemes[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: RichText(
                      text: TextSpan(
                        text: 'GitHub repository',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: appTheme.theme.secondaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(AppInfo.repoURL);
                          },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: RichText(
                      text: TextSpan(
                        text: 'Report a bug',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: appTheme.theme.secondaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(AppInfo.bugReportLink);
                          },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
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
            // Center(
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width * 0.66,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         const Text(
            //           AppInfo.appInfo1,
            //           textAlign: TextAlign.center,
            //         ),
            //         const Padding(
            //           padding: EdgeInsets.only(top: 5),
            //           child: Text(
            //             AppInfo.appInfo2,
            //             textAlign: TextAlign.center,
            //           ),
            //         ),
            //         const Padding(
            //           padding: EdgeInsets.only(top: 5),
            //           child: Text(
            //             AppInfo.appInfo3,
            //             textAlign: TextAlign.center,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
