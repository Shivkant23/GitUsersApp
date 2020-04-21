// import 'package:git/model/weather_response_model.dart';
import 'package:flutter_github_demo/model/ResponseModel.dart';
import 'package:flutter_github_demo/model/items.dart';
import 'api_provider.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();

  Future<ResponseModel> fetchedUsersByLogin(String login) => appApiProvider.getLogin(login);
  Future<Items> fetchedUserDetailsByLogin(String name) => appApiProvider.getDetails(name);
  Future<ResponseModel> fetchedUsersFollowersByLogin(String name) => appApiProvider.getFollowersList(name);
}
