import 'package:flutter_github_demo/model/ResponseModel.dart';
import 'package:flutter_github_demo/model/items.dart';
import 'package:flutter_github_demo/persistence/api_provider.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  test("Testing the user details",()async{
    final apiprovider =  ApiProvider();
    apiprovider.client = MockClient((request)async{
        final mapJson = {'login':"torvalds"};
        return Response(jsonEncode(mapJson), 200);
    });
    Items item = await apiprovider.getDetails("torvalds");
    print(item.login);
    expect(item.login, "torvalds");
  });

  test("Testing total_count searching by login_name",()async{
    final apiprovider =  ApiProvider();
    apiprovider.client = MockClient((request)async{
        final mapJson = {'total_count':164};
        return Response(jsonEncode(mapJson), 200);
    });
    ResponseModel response = await apiprovider.getLogin("torvalds");
    expect(response.totalCount, 164);
  });
}
