class Items {
  String login;
  int id;
  double score;
  String updatedAt;
  int publicGists;
  String bio;
  String name;
  int publicRepos;
  String location;
  String nodeId;
  String avatarUrl;
  int followers;
  int following;

  Items(
      {this.login,
      this.id,
      this.nodeId,
      this.avatarUrl,
      this.score,
      this.bio, 
      this.name, 
      this.publicGists, 
      this.publicRepos,
      this.updatedAt, 
      this.location,
      this.followers, 
      this.following});

  Items.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    avatarUrl = json['avatar_url'];
    score = json['score'] ?? 0;
    updatedAt = json['updated_at'] ?? "--";
    publicGists = json['public_gists'] ?? 0;
    bio = json['bio'] ?? "--";
    publicRepos = json['public_repos'] ?? 0;
    name = json['name'] ?? "--";
    location = json['location'] ?? "--";
    followers = json['followers'] ?? 0;
    following = json['following'] ?? 0;
  }
}