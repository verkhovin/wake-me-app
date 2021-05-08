import 'package:alarm/backend/auth_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class SecurityHeaderHttpClient extends http.BaseClient {
  final http.Client _inner;

  SecurityHeaderHttpClient(this._inner);

  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: AuthAPI.TOKEN_STORAGE_KEY);
    if(token != null) {
      request.headers['token'] = token;
    }
    request.headers['Content-Type'] = 'application/json';
    return _inner.send(request);
  }
}