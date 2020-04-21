import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_github_demo/bloc/bloc_provider.dart';
import 'package:flutter_github_demo/bloc/query_users_bloc.dart';
import 'package:flutter_github_demo/model/ResponseModel.dart';
import 'package:flutter_github_demo/model/items.dart';
import 'package:flutter_github_demo/persistence/repository.dart';
import 'package:flutter_github_demo/ui/selectedUser.dart';


class GitUsers extends StatefulWidget {
  GitUsers({Key key, this.repository}) : super(key: key);
  final Repository repository;

  @override
  _GitUsersState createState() => _GitUsersState();
}

class _GitUsersState extends State<GitUsers> {
  List<Items> _usersList = [];
  
  @override
  Widget build(BuildContext context) {
    final bloc = UsersQueryBloc();
    return BlocProvider<UsersQueryBloc>(
      bloc : bloc, 
      child: Scaffold(
        appBar: _appBar(bloc),
        body: streamBuilder(bloc),
      ),
    );
  }

  streamBuilder(bloc){
    return StreamBuilder<ResponseModel>(
      stream: bloc.usersListStream,
      builder: (context, snapshot) {
        final results = snapshot.data;

        if (results == null) {
          return Center(child: Text('Search Git User'));
        }

        return bodyWidget(results);
      },
    );
  }

  bodyWidget(ResponseModel response){
    _usersList = response.items;
    return Container(
      child: ListView.builder(
        itemCount: _usersList == null ? 0 : _usersList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: _listTile(_usersList[index]),
            onTap: () {
              print(index);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectedUserScreen(
                    login: _usersList[index].login,
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }

  _appBar(bloc){
    return AppBar(
      backgroundColor: Colors.purple[800],
      brightness: Brightness.dark,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            "GitHub",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Material(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Icon(
                    Icons.search,
                    color: Colors.black45,
                  ),
                ),
                suffixIcon: Material(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Icon(
                    Icons.backspace,
                    color: Colors.black45,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                border: InputBorder.none,
              ),
              onChanged: (query) => bloc.submitQuery(query),
            ),
          ),
        ),
      ),
    );
  }

  _listTile(Items _item) {
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
      trailing: Icon(Icons.keyboard_arrow_right),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Id: ${_item.id}"),
          Text("Score: ${_item.score}"),
          Container(),
        ],
      ),
    );
  }
}