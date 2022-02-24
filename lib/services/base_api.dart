import 'dart:convert';

import 'package:http/http.dart' as http;

class BaseApi {
  static var client = http.Client();

  static Future<dynamic> get({required String url}) async {
    return client.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  static Future<dynamic> post(
      {required String url, required Map<String, dynamic> body}) async {
    return await client.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
  }

  static Future<dynamic> delete({required String url}) async {
    return client.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
