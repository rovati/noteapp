import 'package:package_info_plus/package_info_plus.dart';

class PageInfo {
  /* <--- Info page related ---> */
  static final String APP_INFO_1 =
      "Notes is a small project started by Rova to learn a new programming language.";
  static final String APP_INFO_2 =
      "This is by no means an attempt to offer a product with a production level meeting current industry standards.";
  static final String APP_INFO_3 =
      "The project is and always will be open-source and non-profit.";

  static final Uri REPO_URL = Uri.parse("https://github.com/rovati/noteapp");

  static final Uri BUG_REPORT_LINK =
      Uri.parse("https://github.com/rovati/noteapp/issues");

  Future<String> get appVersion =>
      PackageInfo.fromPlatform().then((info) => info.version);
}
