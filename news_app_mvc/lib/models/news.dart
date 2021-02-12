import 'package:news_app_mvc/models/articles.dart';

// News est la classe modèle de réception des données de l'api.
// Elle va parser le json de la réponse et attribuer la liste d'article à notre classe modèle Articles.

class News {
  final int totalResults;
  final List<Articles> articles;

  News({this.totalResults, this.articles});

  factory News.fromJson(Map<String, dynamic> json) {
    var list = json['articles'] as List;
    List<Articles> articlesList = list.map((i) => Articles.fromJson(i)).toList();

    return News(
      totalResults: json['totalResults'] as int,
      articles: articlesList,
    );
  }
}
