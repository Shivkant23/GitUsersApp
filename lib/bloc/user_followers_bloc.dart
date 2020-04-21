import 'package:flutter_github_demo/model/ResponseModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_github_demo/persistence/repository.dart';

class UserFollowersBloc {
  Repository _repository = Repository();

  final allUsersFetcher = PublishSubject<ResponseModel>();

  Observable<ResponseModel> get getAllGitUsers => allUsersFetcher.stream;

  fetchUserFollowersData(String name) async {
    var allUsersResponse = await _repository.fetchedUsersFollowersByLogin(name);
    allUsersFetcher.sink.add(allUsersResponse);
  }

  dispose() {
    allUsersFetcher.close();
  }
}

final userFollowersBloc = UserFollowersBloc();
