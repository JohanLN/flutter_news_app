import 'package:flutter/material.dart';
import 'package:news_app_mvc/controllers/shared_pref_controller.dart';
import 'package:news_app_mvc/custom_widgets/theme_switch.dart';
import 'package:news_app_mvc/custom_widgets/username_dialog.dart';
import 'package:news_app_mvc/models/user.dart';
import 'package:news_app_mvc/views/country_list_selection.dart';
import 'package:news_app_mvc/views/select_fav_categories.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile> {

  User _user;
  bool _isLoading = false;

  @override
  initState() {
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
        setState(() {
          _user = isUserExist;
        });
      }
    } catch (err) {
      print(err);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
      child: _isLoading ? Padding(padding: EdgeInsets.only(top: 300), child: Center(child: CircularProgressIndicator())) : SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CircleAvatar(
                maxRadius: 50,
                backgroundImage: NetworkImage("https://freepngimg.com/thumb/man/22654-6-man.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: InkWell(
                onTap: () {
                  print("Update picture");
                },
                  child: Text("update picture button")
              ),
            ),
            Card(
              margin: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Center(
                  child: ListTile(
                    leading: Icon(Icons.account_circle, size: 40,),
                    title: Text("${this._user.username}", style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor)),
                    onTap: () {
                      createUsernameDialog(context).then((value) async {
                        if (value != null) {
                          setState(() {
                            _user.username = value;
                          });
                          await SharedPrefController().saveUser(_user);
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Center(
                  child: ListTile(
                    leading: Icon(Icons.public, size: 40,),
                    title: Text("Country : ${_user.country}", style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor)),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CountryListSelection(country: _user.country)))
                          .then((value) async {
                            if (value != null) {
                              setState(() {
                                _user.country = value;
                                print(_user.country);
                              });
                              await SharedPrefController().saveUser(_user);
                            }
                          });
                    },
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Center(
                  child: ListTile(
                    leading: Icon(Icons.brightness_6, size: 40,),
                    title: Text("Dark mode", style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor)),
                    trailing: ThemeSwitch()
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Center(
                  child: ListTile(
                    leading: Icon(Icons.favorite_border, size: 40),
                    title: Text("Favorite categories", style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor)),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectFavCategories()));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}