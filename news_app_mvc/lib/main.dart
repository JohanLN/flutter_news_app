import 'package:flutter/material.dart';
import 'package:news_app_mvc/views/master_page.dart';
import 'package:provider/provider.dart';

// Création de 2 themes light & dark

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  appBarTheme: AppBarTheme(brightness: Brightness.dark, color: Colors.orange),
  accentColor: Colors.orange,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12
);

final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    appBarTheme: AppBarTheme(brightness: Brightness.light, color: Colors.white),
    accentColor: Colors.cyan,
    accentIconTheme: IconThemeData(color: Colors.grey),
    dividerColor: Colors.white54
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

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(lightTheme),
      child: NewsAppMvc(),
    )
  );
}

// Classe de notre appication

class NewsAppMvc extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News App MVC",
      // Selecteur de theme
      theme: lightTheme,
      // Ouvre initialement la MasterPage qui gere le header le bottomBar et son contenu
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) {
          return MasterPage();
        }
      },
    );
  }

}