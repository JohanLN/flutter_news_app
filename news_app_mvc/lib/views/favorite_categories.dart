import 'package:flutter/material.dart';
import 'package:news_app_mvc/controllers/shared_pref_controller.dart';
import 'package:news_app_mvc/models/user.dart';

class FavoriteCategories extends StatefulWidget {

  @override
  _FavoriteCategoriesState createState() => _FavoriteCategoriesState();

}

class _FavoriteCategoriesState extends State<FavoriteCategories> {

  User _user;
  bool _isLoading = false;
  int isSelected = 0;

  @override
  void initState() {
    super.initState();
    _setUserInfos();
  }

  _setUserInfos() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var isUserExist = User.fromJson(await SharedPrefController().getUser());
      if (isUserExist != null) {
        setState(() {_user = isUserExist;});
        print(_user.availableTopics);
      }
    } catch(err) {
      setState(() {
        _user = User();
      });
    }finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  BoxDecoration selectedTopic() {
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
            color: Color.fromARGB(255, 230, 230, 230),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _user.availableTopics.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      isSelected = index;
                    });
                  },
                  child: Container(
                    width: 140,
                    child: Center(child: Text("${_user.availableTopics[index]}  ")),
                    decoration: isSelected == index ? selectedTopic() : BoxDecoration()
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}