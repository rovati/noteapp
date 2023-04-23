import 'package:shared_preferences/shared_preferences.dart';

class IDProvider {
  static Future<int> getNextId() async {
    final prefs = await SharedPreferences.getInstance();
    final currID = prefs.getInt('id') ?? 0;
    prefs.setInt('id', currID + 1);
    return currID + 1;
  }
}
