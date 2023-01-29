import 'dart:convert';
import 'dart:io';
import 'package:crypto_app/helper/common/print_function.dart';
import 'package:http/http.dart' as http;

import '../exceptions/exceptions.dart';

class NetworkHelper {
  
  Uri _getUri(String path, {Map<String, dynamic>? queryParameters}) {
    var uri = Uri(scheme: "https", host: "api.wazirx.com", path: "sapi/v1/$path", queryParameters: queryParameters);
    printLog(uri);
    return uri;
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? parameter}) async {
    var responseJson;
    try {
      final response = await http.get(_getUri(url, queryParameters: parameter));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        printLog(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
