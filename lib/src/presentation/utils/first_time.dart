import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeManager {
  static const firstTimeKey = 'is_new';

  static Future<bool> firstTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var isFirstTime = sharedPreferences.getBool(firstTimeKey);
    return isFirstTime ?? true;
  }

  static Future<void> setNotFirstTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(firstTimeKey, false);
  }
}
