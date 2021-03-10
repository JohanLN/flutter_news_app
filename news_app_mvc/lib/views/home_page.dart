import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app_mvc/controllers/news_api_controller.dart';
import 'package:news_app_mvc/models/news.dart';
import 'package:news_app_mvc/custom_widgets/article_card.dart';

// HomePage notre classe de départ. Elle affiche les gros titres du moment.

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  News _news;
  bool _isLoading = false;
  NewsApiController _api = NewsApiController();

  @override
  void initState() {
    super.initState();
    //_fetchTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? Center(child: CircularProgressIndicator()) : Center(
        child: ListView.separated(
          itemCount: 0,//_news.articles.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 400,
              child: Center(child: ArticleCard(articles: _news.articles[index], index: index))
            );
          },
        ),
      ),
    );
  }

  _fetchTopHeadlines() async {

    setState(() {
      _isLoading = true;
    });

    try {

      var news = await _api.getTopHeadlines();
      log("Test api = ${news.articles[0].content}");
      setState(() {
        _news = news;
      });

    } catch(err) {
      setState(() {
        _news = null;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

  }

}