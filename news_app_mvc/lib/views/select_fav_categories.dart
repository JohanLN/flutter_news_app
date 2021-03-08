import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SelectFavCategories extends StatefulWidget {

  @override
  _SelectFavCategoriesState createState() => _SelectFavCategoriesState();

}

class _SelectFavCategoriesState extends State<SelectFavCategories> {

  @override
  void initState() {
    super.initState();
  }

  List<String> topicTitles = ["Business", "Entertainement", "General", "Health", "Science", "Sports", "Technology"];
  List<bool> isChecked = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).accentColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Select topics", style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor)),
        actions: [
            FlatButton(
                onPressed: () {
                  print(isChecked);
                },
                child: const Text("Submit")
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30),
          child: ListView.builder(
              itemCount: topicTitles.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        CheckboxListTile(
                            title: Text("${topicTitles[index]}"),
                            value: isChecked[index],
                            onChanged: (bool value) {
                              setState(() {
                                isChecked[index] = value;
                              });
                            }
                        )
                      ],
                    ),
                  ),
                );
              }
          )
      ),
    );
  }
}