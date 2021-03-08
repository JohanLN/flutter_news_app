import 'package:flutter/material.dart';
import 'package:news_app_mvc/controllers/shared_pref_controller.dart';
import 'package:news_app_mvc/models/shared_preferencies_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ThemeSwitch extends StatefulWidget {
  @override
  _ThemeSwitchState createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  var _darkTheme = true;

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    SharedPrefController().setThemePref(SharedPreferencesTheme.isDarkTheme, value);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Switch(
      activeColor: Theme.of(context).accentColor,
      onChanged: (value) {
        setState(() {
          _darkTheme = value;
        });
        onThemeChanged(value, themeNotifier);
      },
      value: _darkTheme,
    );
  }
}
