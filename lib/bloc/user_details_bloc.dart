import 'package:flutter_github_demo/model/items.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_github_demo/persistence/repository.dart';

class UserDetailsBloc {
  Repository _repository = Repository();

  final allUsersFetcher = PublishSubject<Items>();

  Observable<Items> get getAllGitUsers => allUsersFetcher.stream;

  fetchUserDetails(String name) async {
    var allUsersResponse = await _repository.fetchedUserDetailsByLogin(name);
    allUsersFetcher.sink.add(allUsersResponse);
  }

  dispose() {
    allUsersFetcher.close();
  }
}

final userDetailsBloc = UserDetailsBloc();
