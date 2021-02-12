import 'package:flutter/material.dart';
import 'package:news_app_mvc/views/favorite_articles.dart';
import 'package:news_app_mvc/views/favorite_categories.dart';
import 'package:news_app_mvc/views/home_page.dart';
import 'package:news_app_mvc/views/profile.dart';

// MasterPage gère le header le contenu qui y est affiché et la bottomBar pour la navigation

// StatefulWidget pour pouvoir appliquer des changements d'état aux variables de la classe pendant le runtime
class MasterPage extends StatefulWidget {

  @override
  _MasterPageState createState() => _MasterPageState();

}

class _MasterPageState extends State<MasterPage> {

  String _currentTitle = 'Top Headlines';
  int _index = 0;

  // List de nos widgets de contenu pour pouvoir afficher le contenu en fonction du choix de l'utilisateur sur la bottomBar
  List<Widget> _widgets = <Widget>[
    HomePage(),
    FavoriteCategories(),
    FavoriteArtciles(),
    Profile()
  ];

  // onPressItem effectue des changements (ici le titre de la page) en fontion de la séléction de l'utilisateur sur la bottomBar
  void onPressItem(int index) {
    _index = index;
    switch (index) {
      case 0:
        _currentTitle = "Top Headlines";
        break;
      case 1:
        _currentTitle = "Favorite Categories";
        break;
      case 2:
        _currentTitle = "Favorite Articles";
        break;
      case 3:
        _currentTitle = "Profile";
        break;
    }
    // On applique les changement d'état de nos variables à la fin
    setState(() {});
  }

  // Petit fonction pour afficher et retirer la flèche de retour de notre leading dans le header
  IconButton _leadingButton() {
    if (_index != 0)
      return  IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          onPressItem(0);
        },
      );
    else
      return null;
  }

  // On build le widget
  @override
  Widget build(BuildContext context) {
    // Page de type Scaffold pour pouvoir y assigner un header (AppBar), un body (notre list de widgets) et notre bottomBar (BottomNavigationBar)
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: /*IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            onPressItem(0);
          },
        ),*/
        _leadingButton(),
        title: Text(
           _currentTitle,
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Row(
        children: [
          // Expanded pour que le widget séléctionné remplisse bien tout l'espace restant
          Expanded(child: _widgets.elementAt(_index))
        ],
      ),
      // BottomNavigationBar pour notre bottomBar qui va gérér nos navigations
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.public,
              color: Colors.grey,
            ),
            label: 'Headlines'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.apps_rounded,
              color: Colors.grey,
            ),
            label: 'Topics'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star_border,
              color: Colors.grey,
            ),
            label: 'Favorites'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Colors.grey,
            ),
            label: 'Profile'
          ),
        ],
        currentIndex: _index,
        selectedItemColor: Colors.cyan,
        onTap: onPressItem,
      ),
    );
  }

}