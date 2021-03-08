import 'package:flutter/material.dart';
import 'package:news_app_mvc/controllers/shared_pref_controller.dart';
import 'package:news_app_mvc/models/shared_preferencies_config.dart';
import 'package:news_app_mvc/views/master_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Création de 2 themes light & dark

final darkTheme = ThemeData(
  primaryColor: Colors.black,
  /*textTheme: TextTheme(
    headline1: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
  )*/
  brightness: Brightness.dark,
  backgroundColor: Colors.black,
  accentColor: Colors.blueGrey,

);

final lightTheme = ThemeData(
  primaryColor: Colors.white,
  /*textTheme: TextTheme(
      headline1: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
  )*/
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.cyan,
);

// Classe ThemeNotifier pour notifer l'app d'un changement de theme

class ThemeNotifier with ChangeNotifier {

  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

}

// Main fonction de l'application

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  var isDarkTheme =  await SharedPrefController().getThemePref();
  ThemeData theme;

  if(isDarkTheme != null) {
    theme = isDarkTheme ? darkTheme : lightTheme;
  } else {
    theme = lightTheme;
  }

  runApp(ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(theme),
      child: NewsAppMvc(),
    )
  );
}

// Classe de notre appication

class NewsAppMvc extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News App MVC",
      // Selecteur de theme
      theme:themeNotifier.getTheme() ,
      // Ouvre initialement la MasterPage qui gere le header le bottomBar et son contenu
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) {
          return MasterPage();
        }
      },
    );
  }

}