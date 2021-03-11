import 'package:flutter/material.dart';
import 'package:news_app_mvc/models/articles.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app_mvc/views/page_details.dart';

// Un customWidget qui va nous permettre d'afficher des cartes contenant la preview de nos articles dans la HomePage pour avoir un code plus lisible.

class ArticleCard extends StatefulWidget {
  final Articles articles;
  final int index;

  ArticleCard({Key key, this.articles, this.index}) : super(key: key);

  @override
  _ArticleCardState createState() => _ArticleCardState();

}

class _ArticleCardState extends State<ArticleCard> {

  IconData _isFavorite;
  MaterialColor _isFilled;


  @override
  void initState() {
    super.initState();
    _isFavorite = Icons.favorite_border;
    _isFilled = Colors.grey;
    if (widget.articles.urlToImage == null) {
      widget.articles.urlToImage = "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PageDetails(articles: widget.articles, isFavorite: _isFavorite, isFilled: _isFilled,)));
                    },
                    child: Container(
                      width: 300,
                      height: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("${widget.articles.title}", textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 3,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)),
                          ),
                          Image(image: NetworkImage(widget.articles.urlToImage), height: 200, width: 400,),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("${widget.articles.description}", textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 4, style: TextStyle(fontSize: 11)),
                          )
                        ],
                      ),
                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                        height: 40,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: Icon(_isFavorite),
                                iconSize: 30,
                                color: _isFilled,
                                onPressed: () {
                                  setState(() {
                                    if (_isFavorite != Icons.favorite) {
                                      _isFavorite = Icons.favorite;
                                      _isFilled = Colors.red;
                                    } else {
                                      _isFavorite = Icons.favorite_border;
                                      _isFilled = Colors.grey;
                                    }
                                  });
                                }
                            ),
                            Text("${Jiffy(widget.articles.date).fromNow()}")
                          ],
                        )
                    )
                )
              ],
            ),
          ),
        )
    );
  }

}
