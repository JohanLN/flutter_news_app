class User {

  String username;
  String country;
  List<bool> topics;

  User(
        {
          this.username = "Username",
          this.country = "en",
          this.topics,
        }
      );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json["username"] ?? "username",
      country: json["country"] ?? "en",
      topics: json["topics"].cast<bool>(),
    );
  }
  Map<String, dynamic> toJson() => {
    "username": username,
    "country": country,
    "topics": topics,
  };
}