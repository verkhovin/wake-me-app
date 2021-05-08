import 'dart:convert';
import 'dart:io';

import 'package:alarm/backend/security_header_http_client.dart';
import 'package:alarm/common/exceptions.dart';
import 'package:http/http.dart' as http;

class Api {
  static final String _baseUrl =
      // "https://af0548c1-e796-4e4e-af16-48980863454b.mock.pstmn.io";
      "http://192.168.253.174:8080";

  static http.Client client;

  static Future<Map<String, dynamic>> get(String url) async {
    return _perform(() => getClient().get(Uri.parse(_baseUrl + url)));
  }

  static Future<Map<String, dynamic>> post(String url,
      {String body, Map<String, String> headers}) async {
    return _perform(() => getClient()
        .post(Uri.parse(_baseUrl + url), headers: headers, body: body));
  }

  static Future<dynamic> put(
      String url, String body, Map<String, String> headers) async {
    return _perform(() => getClient()
        .put(Uri.parse(_baseUrl + url), headers: headers, body: body));
  }

  static Future<dynamic> delete(String url, Map<String, String> headers) async {
    return _perform(() => getClient().delete(
          Uri.parse(_baseUrl + url),
          headers: headers,
        ));
  }

  static Future<Map<String, dynamic>> _perform(
      Future<http.Response> Function() method) async {
    var responseJson;
    try {
      final response = await method();
      responseJson = _returnResponse(response);
    } on SocketException {
      throw AppException('Network problems');
    }
    return responseJson;
  }

  static Future<Map<String, dynamic>> _returnResponse(
      http.Response response) async {
    if (response.statusCode < 400) {
      if (response.body == "") {
        return {};
      }
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    }
    throw AppException(
        "Something gone wrong :( / " + response.statusCode.toString());
  }

  static SecurityHeaderHttpClient getClient() {
    if (client == null) {
      client = SecurityHeaderHttpClient(http.Client());
    }
    return client;
  }
}
