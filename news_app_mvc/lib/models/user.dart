class User {

  String username;
  String country;

  User({this.username, this.country});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json["username"] ?? "username",
      country: json["country"] ?? "EN",
    );
  }
  Map<String, dynamic> toJson() => {
    "username": username,
    "country": country
  };
}