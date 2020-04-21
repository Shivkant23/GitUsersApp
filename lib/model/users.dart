import 'package:flutter_github_demo/model/items.dart';

class AllSearchedUsers {
  int totalCount;
  bool incompleteResults;
  List<Items> items;

  AllSearchedUsers({this.totalCount, this.incompleteResults, this.items});

  AllSearchedUsers.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    incompleteResults = json['incomplete_results'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }
}

