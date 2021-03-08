import 'dart:convert';
import 'package:news_app_mvc/models/shared_preferencies_config.dart';
import 'package:news_app_mvc/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefController {

  setThemePref(String isDarkTheme, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPreferencesTheme.isDarkTheme, value);

    return prefs;
  }

  getThemePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isDarkTheme = prefs.getBool((SharedPreferencesTheme.isDarkTheme));
    return isDarkTheme;
  }

  saveUser(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userData", json.encode(value));
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString("userData"));
  }

}