import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:note_app/util/constant/app_info.dart';
import 'package:note_app/util/constant/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  final Future<String> _version = PageInfo().appVersion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Themes.background,
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.66,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    PageInfo.APP_INFO_1,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      PageInfo.APP_INFO_2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      PageInfo.APP_INFO_3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: new RichText(
                      text: TextSpan(
                        text: 'GitHub repository',
                        style: new TextStyle(
                            decoration: TextDecoration.underline,
                            color: Themes.red),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            launch(PageInfo.REPO_URL);
                          },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: new RichText(
                      text: TextSpan(
                        text: 'Report a bug',
                        style: new TextStyle(
                            decoration: TextDecoration.underline,
                            color: Themes.red),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            launch(PageInfo.BUG_REPORT_LINK);
                          },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: FutureBuilder<String>(
                        future: _version,
                        builder: (context, snapshot) {
                          var version = 'retreiving app version...';
                          if (snapshot.hasData) {
                            version = 'v' + snapshot.data!;
                          }
                          if (snapshot.hasError) {
                            version = 'failed to retreive the app version';
                          }
                          return Text(
                            version,
                            style: TextStyle(fontSize: 10),
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
