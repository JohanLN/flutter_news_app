import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app_mvc/controllers/news_api_controller.dart';
import 'package:news_app_mvc/controllers/shared_pref_controller.dart';
import 'package:news_app_mvc/models/news.dart';
import 'package:news_app_mvc/custom_widgets/article_card.dart';
import 'package:news_app_mvc/models/user.dart';

// HomePage notre classe de départ. Elle affiche les gros titres du moment.

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  News _news;
  bool _isLoading = false;
  NewsApiController _api = NewsApiController();
  User _user;

  @override
  void initState() {
    super.initState();
    _setupPageResults();
  }

  _setupPageResults() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var isUserExist = User.fromJson(await SharedPrefController().getUser());
      if (isUserExist != null) {
        setState(() {_user = isUserExist;});
      }
      await _fetchTopHeadlines();
    } catch(err) {
      setState(() {
        _user = User();
        _user.topics = [true,true,true,true,true,true,true];
        _user.availableTopics = ["Business", "Entertainement", "General", "Health", "Science", "Sports", "Technology"];
        _user.favArticles = [];
      });
      await SharedPrefController().saveUser(_user);
      await _fetchTopHeadlines();
    }finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _fetchTopHeadlines() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var news = await _api.getTopHeadlines(_user.country);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? Center(child: CircularProgressIndicator()) : Center(
        child: ListView.separated(
          itemCount: _news.articles.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 500,
              child: Center(child: ArticleCard(articles: _news.articles[index], index: index, user: _user))
            );
          },
        ),
      ),
    );
  }
}