import 'dart:convert';
import 'dart:io';
import 'package:flutter_github_demo/model/ResponseModel.dart';
import 'package:flutter_github_demo/model/items.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' show Client;

class ApiProvider {
  Client client = Client();

  Future<ResponseModel> getHttpResponse(String _url)async{
    bool mIsError = false;
    String mErrorMsg = "";
    ResponseModel _responseModel = new ResponseModel();
    try{
      Map<String,String> headers = {
        'Content-type' : 'application/json', 
        'Accept': 'application/json',
      };
      final response = await client.get(_url);
      
      if(response == null){
        mIsError = false;
        mErrorMsg = "Received null response from server."+response.statusCode.toString();
      }else{
        switch(response.statusCode){
          case 200:
            try{
              print(response.body);
              mIsError = true;
              mErrorMsg = "success";
              _responseModel = ResponseModel.fromJson(jsonDecode(response.body));
            } on FormatException catch(e){
              print(e);
              mIsError = false;
              mErrorMsg = "Received wrong body contents."+response.statusCode.toString();
            }
            break;
          case 400:
            print(response.statusCode);
            break;
          case 401:
            print(response.statusCode);
            break;
          default:
            print(response.statusCode);
            mIsError = false;
            mErrorMsg = "Invalid server response: " + response.statusCode.toString();
            Fluttertoast.showToast(msg: mErrorMsg);
            break;
        }
      }
    }on SocketException catch(e){
      mIsError = false;
      mErrorMsg = "Failed to connect to server. " + e.message;
    } on Exception catch(e){
      mIsError = false;
      mErrorMsg = "Unknown error $e.";
    }
    if((!mIsError) || (_responseModel == null)){
      // _responseModel.setIsCorrect(mIsError);
      _responseModel.setMessage(mErrorMsg);
      return _responseModel;
    }
    // _responseModel.setIsCorrect(mIsError);
    _responseModel.setMessage(mErrorMsg);
    return _responseModel;
  }


  Future<ResponseModel> getLogin(String login)async{
    String _url = "https://api.github.com/search/users?q="+login+"&page=1";
    return await getHttpResponse(_url);
  }

  Future<ResponseModel> getFollowersList(String userName)async{
    String _url = "https://api.github.com/users/"+userName+"/followers";
    return await getResponseFollowers(_url);
  }

  Future<Items> getDetails(String userName)async{
    String _url = "https://api.github.com/users/"+userName;
    return await getResponse(_url);
  }

  Future<Items> getResponse(String _url)async{
    bool mIsError = false;
    String mErrorMsg = "";
    Items _item = new Items();
    try{
      Map<String,String> headers = {
        'Content-type' : 'application/json', 
        'Accept': 'application/json',
      };
      final response = await client.get(_url);
      
      if(response == null){
        mIsError = false;
        mErrorMsg = "Received null response from server."+response.statusCode.toString();
      }else{
        switch(response.statusCode){
          case 200:
            try{
              print(response.body);
              mIsError = true;
              mErrorMsg = "success";
              // String parsedJson = json.decode(response.body);
              _item = Items.fromJson(jsonDecode(response.body));
            } on FormatException catch(e){
              print(e);
              mIsError = false;
              mErrorMsg = "Received wrong body contents."+response.statusCode.toString();
            }
            break;
          case 400:
            print(response.statusCode);
            break;
          case 401:
            print(response.statusCode);
            break;
          default:
            print(response.statusCode);
            mIsError = false;
            mErrorMsg = "Invalid server response: " + response.statusCode.toString();
            Fluttertoast.showToast(msg: mErrorMsg);
            break;
        }
      }
    }on SocketException catch(e){
      mIsError = false;
      mErrorMsg = "Failed to connect to server. " + e.message;
    } on Exception catch(e){
      mIsError = false;
      mErrorMsg = "Unknown error $e.";
    }
    if((!mIsError) || (_item == null)){
      // _responseModel.setIsCorrect(mIsError);
      // _item.setMessage(mErrorMsg);
      return _item;
    }
    return _item;
  }

  Future<ResponseModel> getResponseFollowers(String _url)async{
    bool mIsError = false;
    String mErrorMsg = "";
    ResponseModel _responseModel = new ResponseModel();
    try{
      Map<String,String> headers = {
        'Content-type' : 'application/json', 
        'Accept': 'application/json',
      };
      final response = await client.get(_url);
      
      if(response == null){
        mIsError = false;
        mErrorMsg = "Received null response from server."+response.statusCode.toString();
      }else{
        switch(response.statusCode){
          case 200:
            try{
              print(response.body);
              mIsError = true;
              mErrorMsg = "success";
              // String parsedJson = json.decode(response.body);
              String parsedJson = jsonEncode({"items":jsonDecode(response.body)});
              _responseModel = ResponseModel.fromJson(jsonDecode(parsedJson));
            } on FormatException catch(e){
              print(e);
              mIsError = false;
              mErrorMsg = "Received wrong body contents."+response.statusCode.toString();
            }
            break;
          case 400:
            print(response.statusCode);
            break;
          case 401:
            print(response.statusCode);
            break;
          default:
            print(response.statusCode);
            mIsError = false;
            mErrorMsg = "Invalid server response: " + response.statusCode.toString();
            break;
        }
      }
    }on SocketException catch(e){
      mIsError = false;
      mErrorMsg = "Failed to connect to server. " + e.message;
    } on Exception catch(e){
      mIsError = false;
      mErrorMsg = "Unknown error $e.";
    }
    if((!mIsError) || (_responseModel == null)){
      // _responseModel.setIsCorrect(mIsError);
      _responseModel.setMessage(mErrorMsg);
      return _responseModel;
    }
    // _responseModel.setIsCorrect(mIsError);
    _responseModel.setMessage(mErrorMsg);
    return _responseModel;
  }
}