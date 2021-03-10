import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app_mvc/controllers/save_profile_picture.dart';
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
  Image image;

  @override
  initState() {
    super.initState();
    _setUserInfos();
    loadSavedImage();
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

  pickImage(ImageSource imageSource) async {
    final _pickImage = await ImagePicker.pickImage(source: imageSource);

    if (_pickImage != null) {
      setState(() {
        image = Image.file(_pickImage);
      });
      SaveProfilePicture.saveImageToPrefs(SaveProfilePicture.base64String(_pickImage.readAsBytesSync()));
    } else {
      print("Error when picking image.");
    }
  }

  void loadSavedImage() async {
    var isImage = await SharedPrefController().loadSavedImage();
    if (isImage != null) {
      setState(() {
        image = isImage;
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
              padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
              child: InkWell(
                onTap: () {
                  _showPickOptionsDialog(context);
                },
                child: CircleAvatar(
                  maxRadius: 80,
                  backgroundImage: image != null ? image.image : NetworkImage("https://cdn2.iconfinder.com/data/icons/universal-simple/288/Simple-63-512.png"),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectFavCategories(isChecked: _user.topics, availableTopics: _user.availableTopics,))).then((value) async {
                        if (value != null) {
                          setState(() {
                            _user.topics = value["boolTab"];
                            _user.availableTopics = value["stringTab"];
                          });
                          await SharedPrefController().saveUser(_user);
                        }
                      });
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

  void _showPickOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(child: Icon(Icons.picture_in_picture, size: 17)),
                          TextSpan(text: "   Picture from gallery", style: TextStyle(color: Theme.of(context).accentColor, fontSize: 17)),
                        ]
                      ),
                    ),
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(child: Icon(Icons.camera, size: 17)),
                          TextSpan(text: "  Take a picture", style: TextStyle(color: Theme.of(context).accentColor, fontSize: 17)),
                        ]
                      ),
                    ),
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
    );
  }
}