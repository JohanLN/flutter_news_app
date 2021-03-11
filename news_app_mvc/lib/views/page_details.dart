import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app_mvc/models/articles.dart';
import 'package:url_launcher/url_launcher.dart';

class PageDetails extends StatefulWidget {

  final Articles articles;
  IconData isFavorite;
  MaterialColor isFilled;


  PageDetails({Key key, this.articles, this.isFavorite, this.isFilled}) : super(key: key);

  @override
  _PageDetailsState createState() => _PageDetailsState();

}

class _PageDetailsState extends State<PageDetails> {

  @override
  void initState() {
    super.initState();
    _resizeContentString();
  }

  _resizeContentString() {
    if (widget.articles.description == null) {
      widget.articles.description = "No description for this article";
    }
    if (widget.articles.content != null) {
      if (widget.articles.content.length <= 201)
        return;
      int i = 0;
      int j = 0;
      for (i = 0; widget.articles.content[i] != '['; i++);
      for (j = 0; widget.articles.content[i] != ']'; i++, j++);
      j++;
      widget.articles.content = widget.articles.content.substring(
          0, widget.articles.content.length - j);
    } else {
      widget.articles.content = "No content for this article.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 100,
          title: Text(
            widget.articles.title,
            style: TextStyle(fontSize: 15, color: Theme.of(context).accentColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
        )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                  image: NetworkImage(
                      widget.articles.urlToImage
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.articles.description, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            child: Text(widget.articles.content)
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
            child: InkWell(
              onTap: () {
                _launchUrl(widget.articles.url);
              },
              child: Text(
                "Voir plus...",
                style: TextStyle(fontSize: 13, color: Colors.blueAccent),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(widget.isFavorite),
                      iconSize: 30,
                      color: widget.isFilled,
                      onPressed: () {
                        setState(() {
                          if (widget.isFavorite != Icons.favorite) {
                            widget.isFavorite = Icons.favorite;
                            widget.isFilled = Colors.red;
                          } else {
                            widget.isFavorite = Icons.favorite_border;
                            widget.isFilled = Colors.grey;
                          }
                        });
                      }
                  ),
                  Text("${Jiffy(widget.articles.date).fromNow()}")
                ]
            ),
          ),
        ],
      ),
    );
  }
}

_launchUrl(url) async {

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "Couldn't open $url";
  }

}