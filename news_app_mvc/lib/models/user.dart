class User {

  String username;
  String country;
  List<bool> topics;
  List<String> availableTopics;

  User(
        {
          this.username = "Username",
          this.country = "gb",
          this.topics,
          this.availableTopics,
        }
      );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json["username"] ?? "username",
      country: json["country"] ?? "gb",
      topics: json["topics"].cast<bool>(),
      availableTopics: json["availableTopics"].cast<String>(),
    );
  }
  Map<String, dynamic> toJson() => {
    "username": username,
    "country": country,
    "topics": topics,
    "availableTopics": availableTopics,
  };
}