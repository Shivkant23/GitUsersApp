import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_demo/model/ResponseModel.dart';
import 'package:flutter_github_demo/model/items.dart';
import 'package:flutter_github_demo/bloc/user_followers_bloc.dart';

class FollowersScreen extends StatefulWidget {
  FollowersScreen({Key key, this.login, this.name}) : super(key: key);
  String login, name;

  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> with SingleTickerProviderStateMixin {
  List<Items> _followersList = [];
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Followers'),
    Tab(text: 'Following'),
  ];

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: myTabs.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userFollowersBloc.fetchUserFollowersData(widget.login);
    return Scaffold(
      appBar: _appBar(),
      body: 
       StreamBuilder(
        stream: userFollowersBloc.allUsersFetcher,
        builder: (context, AsyncSnapshot<ResponseModel> snapshot) {
          if (snapshot.hasData) {
            return getTabs(snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        }
      ),
    );
  }

  _appBar(){
    return AppBar(
        backgroundColor: Colors.purple[800],  
        brightness: Brightness.dark,
        actions: <Widget>[
          Icon(Icons.ac_unit, color: Colors.purple[800],)
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text(
              widget.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),  
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              indicatorColor: Colors.purple,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: myTabs
            ),
          ),
        ),
      );
  }

  getTabs(ResponseModel allUsers){
    _followersList = allUsers.items;
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        Followers(list: _followersList,),
        Followers(list: _followersList,),
      ]
    );
  }
}

class Followers extends StatelessWidget {
  const Followers({Key key, this.list}) : super(key: key);
  final List list;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
          itemCount: list == null ? 0 : list.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              child: _listTile(list[index]),
              onTap: (){
                print(index);
              },
            );
          }
        ),
      );
  }

  _listTile(Items _item){
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(
            image: CachedNetworkImageProvider(_item.avatarUrl),
            fit: BoxFit.fill,
          ),
        ),
      ),
      title: Text(_item.login),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Id: ${_item.id}"),
        ],
      ),
    );
  }
}