import 'dart:convert';
import 'dart:io';
import 'package:drohealthapp/model/generic_response.dart';
import 'package:drohealthapp/utility/constants.dart' as Constants;
import 'package:http/http.dart' as http;
import 'app_exceptions.dart';

class ApiClient {
  final httpClient = http.Client();

  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await http.get(url);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }


  Future<dynamic> postForm(String url, Map body) async {
    print('Api Post, url :' + url);
    print('parameters:' + body.toString());

    var responseJson;
    try {
      final response = await http.post(url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    print("responsejson" + responseJson.toString());

    return responseJson;
  }


  dynamic _returnResponse(http.Response response) {
    var responseJson = response.body;
    GenericResponse genericResponse =
        GenericResponse.fromJson(jsonDecode(response.body));
    print("response :" + responseJson.toString());
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 201:
        return responseJson;
      case 302:
        return responseJson;
      case 400:
        throw BadRequestException(genericResponse.message);
      case 401:
      case 403:
        throw UnauthorisedException(genericResponse.message);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communicating with Server with StatusCode : ${response.statusCode}');
    }
  }
}
