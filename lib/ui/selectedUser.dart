import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_demo/model/items.dart';
import 'package:flutter_github_demo/bloc/user_details_bloc.dart';
import 'package:flutter_github_demo/ui/animation.dart';
import 'package:flutter_github_demo/ui/followersScreen.dart';
import 'package:share/share.dart';

class SelectedUserScreen extends StatefulWidget {
  SelectedUserScreen({Key key, this.login}) : super(key: key);
  String login;

  @override
  _SelectedUserScreenState createState() => _SelectedUserScreenState();
}

class _SelectedUserScreenState extends State<SelectedUserScreen> {
  String details = "";

  @override
  Widget build(BuildContext context) {
    userDetailsBloc.fetchUserDetails(widget.login);
    return Scaffold(
      appBar: _appBar(),
      body: StreamBuilder(
          stream: userDetailsBloc.allUsersFetcher,
          builder: (context, AsyncSnapshot<Items> snapshot) {
            if (snapshot.hasData) {
              return _bodyWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.purple[800],
      brightness: Brightness.dark,
      title: Center(
        child: Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.cloud_upload),
          onPressed: () {
            final RenderBox box = context.findRenderObject();
            Share.share(details,
                subject: "Details",
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
          },
        ),
      ],
    );
  }

  _bodyWidget(Items _item) {
    shareData(_item);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Card(
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          AnimatedOpacity(
                            opacity: 1,
                            duration: Duration(seconds: 1),
                            child: _gotoDetailsPage(context, _item),
                          );
                          // _gotoDetailsPage(context, _item);
                        },
                        child: Hero(
                          tag: 'profile',
                          child: Container(
                            width: 150,
                            height: 150,
                            margin: EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                image:CachedNetworkImageProvider(_item.avatarUrl),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        _item.name,
                        style: TextStyle(fontSize: 26),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.location_on),
                          Text(
                            _item.location,
                            style: TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
                      GestureDetector(
                        child: Text(
                          "${_item.followers} Followers   |   ${_item.following} Following",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FollowersScreen(login: _item.login, name: _item.name,),
                            ),
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => HeroAnimationRecipe(
                          //       title: _item.name,
                          //     ),
                          //   ),
                          // );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 25, 5, 5),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      getText("Bio:", true),
                      getText(_item.bio ?? "", false),
                      getText("Public repositories:", true),
                      getText(_item.publicRepos.toString() ?? "", false),
                      getText("Public gists:", true),
                      getText(_item.publicGists.toString() ?? "", false),
                      getText("Updated at:", true),
                      getText(_item.updatedAt ?? "", false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getText(String label, bool changeColor) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        label,
        style: TextStyle(color: changeColor ? Colors.black : Colors.black54),
      ),
    );
  }

  shareData(Items item) {
    details =
        "Name: ${item.name}, login: ${item.login},  Name: ${item.score}, Name: ${item.updatedAt}";
  }

  _gotoDetailsPage(BuildContext context,Items item) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => Scaffold(
        backgroundColor: Color(0xFFFF9844),
        body: Container(
        child: Hero(
          tag: 'profile',
            child: Center(
              // child: Image.asset('assets/Octocat.png'),
              child: Container(
                margin: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:CachedNetworkImageProvider(item.avatarUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
          ),
        ),
      ),
    )
    ));
  }
}
