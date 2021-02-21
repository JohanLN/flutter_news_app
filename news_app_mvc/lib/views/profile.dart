import 'package:flutter/material.dart';
import 'package:news_app_mvc/custom_widgets/theme_switch.dart';
import 'package:news_app_mvc/views/select_fav_categories.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile> {

  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      title: Text("Username", style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor)),
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
                      title: Text("Country", style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor)),
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