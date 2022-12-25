import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  /* <--- Info page related ---> */
  static const String appInfo1 =
      'Notes is a small project started by Rova to learn a new programming language.';
  static const String appInfo2 =
      'This is by no means an attempt to offer a product with a production level meeting current industry standards.';
  static const String appInfo3 =
      'The project is and always will be open-source and non-profit.';

  static final Uri repoURL = Uri.parse('https://github.com/rovati/noteapp');

  static final Uri bugReportLink =
      Uri.parse('https://github.com/rovati/noteapp/issues');

  Future<String> get appVersion =>
      PackageInfo.fromPlatform().then((info) => info.version);
}
