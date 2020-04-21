

import 'dart:async';

import 'package:flutter_github_demo/bloc/bloc.dart';
import 'package:flutter_github_demo/model/ResponseModel.dart';
import 'package:flutter_github_demo/persistence/repository.dart';


class UsersQueryBloc extends Bloc{
  final _controller = StreamController<ResponseModel>();
  Repository _repository = Repository();
  Stream<ResponseModel> get usersListStream => _controller.stream;

  void submitQuery(String query) async {
    var allUsersResponse = await _repository.fetchedUsersByLogin(query);
    _controller.sink.add(allUsersResponse);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
