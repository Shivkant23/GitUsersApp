import 'package:flutter_github_demo/model/ResponseModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_github_demo/persistence/repository.dart';

class AllUsersBloc {
  Repository _repository = Repository();

  //Create a PublicSubject object responsible to add the data which is got from
  // the server in the form of allUsersResponse object and pass it to the UI screen as a stream.
  final allUsersFetcher = PublishSubject<ResponseModel>();

  //This method is used to pass the weather response as stream to UI
  Observable<ResponseModel> get getAllGitUsers => allUsersFetcher.stream;

  fetchAllUsersData(String login) async {
    var allUsersResponse = await _repository.fetchedUsersByLogin(login);
    allUsersFetcher.sink.add(allUsersResponse);
  }

  dispose() {
    allUsersFetcher.close();
  }
}

final allusersBloc = AllUsersBloc();
