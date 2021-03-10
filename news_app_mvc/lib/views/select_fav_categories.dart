import 'package:flutter/material.dart';

class SelectFavCategories extends StatefulWidget {

  List<bool> isChecked;
  List<String> availableTopics;

  SelectFavCategories({Key key, this.isChecked, this.availableTopics}) : super(key: key);

  @override
  _SelectFavCategoriesState createState() => _SelectFavCategoriesState();

}

class _SelectFavCategoriesState extends State<SelectFavCategories> {

  List<String> topicTitles = ["Business", "Entertainement", "General", "Health", "Science", "Sports", "Technology"];
  List<bool> isChecked = [false, false, false, false, false, false, false];
  List<String> chooseTopic = [];

  @override
  void initState() {
    super.initState();
    if (widget.isChecked != null && widget.isChecked.length > 0) {
      setState(() {
        isChecked = widget.isChecked;
      });
    }
    else {
      isChecked = [false, false, false, false, false, false, false];
    }
    if (widget.availableTopics != null && widget.isChecked.length > 0) {
      setState(() {
        chooseTopic = widget.availableTopics;
      });
    }
    else {
      chooseTopic = [];
    }
  }


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
                  Navigator.pop(context, {"boolTab":isChecked, "stringTab":chooseTopic});
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
                                if (isChecked[index] == false)
                                  chooseTopic.add(topicTitles[index]);
                                else
                                  chooseTopic.remove(topicTitles[index]);
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