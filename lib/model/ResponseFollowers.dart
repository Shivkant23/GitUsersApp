import 'package:flutter_github_demo/model/items.dart';

class ResponseFolowers {
  List<Items> items;
  String status;
  int statusCode;
  bool isCorrect;
  String message;
  String error;

  ResponseFolowers();

  ResponseFolowers.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  String get getMessage => message;
  bool get getIsCorrect => isCorrect;

  void setMessage(String msg){
    message = msg;
  }

  void setIsCorrect(bool correctflag){
    isCorrect = correctflag;
  }

  void setData(List<Items> pData){
    items = pData;
  }
}

// class Items{
//   String _login;
//   int _id;
//   double _score;
//   String _avatarUrl;
//   int _followers;
//   int _following;
//   String _updatedAt;
//   int _publicGists;
//   String _bio;
//   String _name;
//   int _publicRepos;
//   String _location;

//   Items();
//   // "followers": 112770,
//   // "following": 0,
//   // "updated_at": "2020-04-14T22:19:10Z",
//   // "public_gists": 0,
//   // "bio": null,
//   // "public_repos": 6,
//   // "name": "Linus Torvalds",
//   // "company": "Linux Foundation",
//   // "location": "Portland, OR",
  
//   String get getLogin => _login;
//   int get getId => _id;
//   double get getScore => _score;
//   String get getAvatarUrl => _avatarUrl;
//   int get getFollowers => _followers;
//   int get getFollowing => _following;
//   String get getUpdatedAt => _updatedAt;
//   int get getPublicGists => _publicGists;
//   String get getBio => _bio;
//   int get getPublicRepos => _publicRepos;
//   String get getName => _name;
//   String get getLocation => _location;


//   Items.fromJson(Map<String, dynamic> json){
//     _login = json['login'] ?? "--";
//     _id = json['id'] ?? 0;
//     _avatarUrl = json['avatar_url'] ?? "--";
//     _score = json['score'] ?? 0;
//     _followers = json['followers'] ?? 0;
//     _following = json['following'] ?? 0;
//     _updatedAt = json['updated_at'] ?? "--";
//     _publicGists = json['public_gists'] ?? 0;
//     _bio = json['bio'] ?? "--";
//     _publicRepos = json['public_repos'] ?? 0;
//     _name = json['name'] ?? "--";
//     _location = json['location'] ?? "--";
//   }
// }