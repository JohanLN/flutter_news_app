import 'package:flutter/material.dart';
import 'package:news_app_mvc/controllers/news_api_controller.dart';
import 'package:news_app_mvc/controllers/shared_pref_controller.dart';
import 'package:news_app_mvc/custom_widgets/article_card.dart';
import 'package:news_app_mvc/models/news.dart';
import 'package:news_app_mvc/models/user.dart';

class FavoriteCategories extends StatefulWidget {

  @override
  _FavoriteCategoriesState createState() => _FavoriteCategoriesState();

}

class _FavoriteCategoriesState extends State<FavoriteCategories> {

  User _user;
  bool _isLoading = false;
  int _isSelected = 0;
  String _categorySelected;
  News _news;
  NewsApiController _api = NewsApiController();

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
        setState(() {
          _user = isUserExist;
          _categorySelected = _user.availableTopics[0];
        });
      }
      await _fetchCategoryHeadlines();
    } catch(err) {
      setState(() {
        _user = User();
        _categorySelected = "general";
      });
      await _fetchCategoryHeadlines();
    }finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _fetchCategoryHeadlines() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var news = await _api.getCategoryHeadlines(_user.country, _categorySelected);
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

  BoxDecoration _selectedTopic() {
    return BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: Theme
                    .of(context)
                    .accentColor,
                width: 1.5
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Center(child: CircularProgressIndicator()) : Scaffold(
      body: Column(
        children: [
          Container(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _user.availableTopics.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    setState(() {
                      _isSelected = index;
                      _categorySelected = _user.availableTopics[index];
                    });
                    await _fetchCategoryHeadlines();
                  },
                  child: Container(
                    width: 140,
                    child: Center(child: Text("${_user.availableTopics[index]}  ")),
                    decoration: _isSelected == index ? _selectedTopic() : BoxDecoration()
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _news.articles.length,
              scrollDirection: Axis.vertical,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 500,
                  child: Center(
                      child: ArticleCard(
                        articles: _news.articles[index],
                        index: index,
                        user: _user,
                      )
                  ),
                );
              },
            )
          )
        ],
      ),
    );
  }
}