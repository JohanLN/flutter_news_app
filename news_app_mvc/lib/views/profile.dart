import 'package:flutter/material.dart';
import 'package:news_app_mvc/custom_widgets/profile_card.dart';
import 'package:news_app_mvc/views/select_fav_categories.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile> {

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
              InkWell(
                onTap: () {
                  print("Username");
                },
                child: ProfileCard(cardTitle: "Username", cardIcon: Icons.account_circle_rounded,)
              ),
              InkWell(
                onTap: () {
                  print("Country");
                },
                child: ProfileCard(cardTitle: "Country", cardIcon: Icons.public,)
              ),
              InkWell(
                onTap: () {
                  print("Dark mode");
                },
                child: ProfileCard(cardTitle: "Dark mode", cardIcon: Icons.brightness_6)
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectFavCategories()));
                },
                child: ProfileCard(cardTitle: "Favorite categories", cardIcon: Icons.favorite_border,)
              ),
            ],
          ),
      )
    );
  }

}