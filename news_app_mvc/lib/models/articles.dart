// Articles est une classe qui va récupérer et parser les json contenant la liste d'article de la classe modèle News

class Articles {

  final String title;
  String description;
  String content;
  final String url;
  String urlToImage;
  final String date;

  Articles({this.title, this.description, this.content, this.url, this.urlToImage, this.date});

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      title: json['title'] as String,
      description: json['description'] as String,
      content: json['content'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String,
      date: json['publishedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "content": content,
    "url": url,
    "urlToImage": urlToImage,
    "date": date
  };

}