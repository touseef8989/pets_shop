import 'package:shared_preferences/shared_preferences.dart';

class MyPrefferenc {
  static SharedPreferences? _preferences;
  static String keyName = "email";

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future saveEmail(String n) async {
    return _preferences!.setString(keyName, n);
  }

  static String getEmail() {
    return _preferences!.getString(keyName) ?? "";
  }
}
