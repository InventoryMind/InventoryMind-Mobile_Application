import 'package:shared_preferences/shared_preferences.dart';

class TokenRolePreferences {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setToken(String token) async {
    await _preferences.setString("token", token);
  }

  static String getToken() {
    String? _temp = _preferences.getString("token");
    if ((_temp == null) || (_temp == "clear")) {
      return "empty";
    } else {
      return _temp;
    }
  }

  static Future setUserRole(String userRole) async {
    await _preferences.setString("userRole", userRole);
  }

  static String getUserRole() {
    String? _temp = _preferences.getString("userRole");
    if ((_temp == null) || (_temp == "clear")) {
      return "empty";
    } else {
      return _temp;
    }
  }
}
