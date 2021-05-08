import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api.dart';

class AuthAPI {
  static const TOKEN_STORAGE_KEY = "TOKEN";

  Future<void> register(String login, String password) async {
    return await saveToken(() => Api.post("/register", body: jsonEncode({
      'login': login,
      'password': password
    })));
  }

  Future<void> login(String login, String password) async {
    return await saveToken(() => Api.post("/login", body: jsonEncode({
      'login': login,
      'password': password
    })));
  }

  Future<void> logout() async {
    final storage = new FlutterSecureStorage();
    await storage.deleteAll();
  }

  Future<void> saveToken(Future<Map<String, dynamic>> Function() action) async {
    var response = await action();
    final storage = new FlutterSecureStorage();
    storage.write(key: TOKEN_STORAGE_KEY, value: response["token"]);
  }
}