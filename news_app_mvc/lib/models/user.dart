import 'dart:convert';
import 'package:news_app_mvc/models/articles.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {

  String username;
  String country;
  List<bool> topics;
  List<String> availableTopics;
  List<Articles> favArticles;

  User(
        {
          this.username = "Username",
          this.country = "gb",
          this.topics,
          this.availableTopics,
          this.favArticles,
        }
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}