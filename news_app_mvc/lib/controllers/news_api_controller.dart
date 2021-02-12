import 'dart:convert';

import 'package:news_app_mvc/network/news_api_calls.dart';
import 'package:news_app_mvc/models/news.dart';

const String URL_EVERYTHING = "http://newsapi.org/v2/everything?";
const String URL_TOP_HEADLINES = "http://newsapi.org/v2/top-headlines?";
const String COUNTRY = "country=fr&";
const String API_KEY = "apiKey=36cb3a17beaa4169bb99ff9fc8118563";

// Notre classe controller pour les calls api. Le controller va faire la requete http et renvoyer la réponse à nos modèles

class NewsApiController {

  // Funtion pour récupérer et envoyer les gros titres du moment, à notre modèle News.
  Future<News> getTopHeadlines() async {
    var response = await NewsApiCalls().get(URL_TOP_HEADLINES + COUNTRY + API_KEY);
    return News.fromJson(jsonDecode(response));
  }

}