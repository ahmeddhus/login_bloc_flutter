import 'package:flutter/material.dart';
import 'package:flutter_app/model/login_model.dart';
import 'package:flutter_app/model/login_response_model.dart';
import 'package:flutter_app/utils/config.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginRepository {
  static Future<LoginResponseModel> logIn(
      {@required LoginModel loginModel}) async {
    var response = await http.post('$baseURL/login/user',
        body: jsonEncode(loginModel.toJson()),
        headers: {"Content-Type": "application/json"});
    print(utf8.decode(response.bodyBytes));

    return LoginResponseModel.fromJson(
        JsonDecoder().convert(utf8.decode(response.bodyBytes)));
  }
}
