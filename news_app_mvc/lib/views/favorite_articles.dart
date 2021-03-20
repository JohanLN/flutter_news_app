import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app_mvc/controllers/news_api_controller.dart';
import 'package:news_app_mvc/controllers/shared_pref_controller.dart';
import 'package:news_app_mvc/models/news.dart';
import 'package:news_app_mvc/custom_widgets/article_card.dart';
import 'package:news_app_mvc/models/user.dart';

class FavoriteArtciles extends StatefulWidget {

  @override
  _FavoriteArtcilesState createState() => _FavoriteArtcilesState();

}

class _FavoriteArtcilesState extends State<FavoriteArtciles> {


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
    } catch(err) {
      print("Error !");
    }finally {
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
          itemCount: _user.favArticles.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 500,
                child: Center(child: ArticleCard(articles: _user.favArticles[index], index: index, user: _user))
            );
          },
        ),
      ),
    );
  }

}