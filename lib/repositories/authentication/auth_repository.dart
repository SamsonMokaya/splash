// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:geolocation_flutter/constants/v2urls/urls_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import 'base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  @override
  Future<UserModel?> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String admisionNumber,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse(Environment.registerUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
          "adm_num": admisionNumber,
          "first_name": firstName
        }));
    final responseData = jsonDecode(response.body);
    print(responseData);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.statusCode);
      UserModel user = UserModel.fromJson(responseData['data']);
      preferences.setString('user', jsonEncode(user));
      return user;
    } else if (responseData.containsKey('message')) {
      throw Exception(responseData['message']);
    } else {
      print(response.statusCode);
      throw Exception('Failed to sign up user');
    }
  }

  @override
  Future<UserModel?> login(
      {required String email, required String password}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse(Environment.loginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {"adm_num": email, "password": password},
        ));

    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(responseData['data']);
      preferences.setString('user', jsonEncode(user));
      return user;
    } else if (responseData.containsKey('message')) {
      throw Exception(responseData['message']);
    } else {
      throw Exception('Failed to login user');
    }
  }

  @override
  Future<bool> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool loggedOut = await preferences.remove('user');
    return loggedOut;
  }

  @override
  Future<UserModel> checkUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userFromPrefs = preferences.getString('user');
    try {
      if (userFromPrefs != null) {
        final userString = jsonDecode(userFromPrefs);
        UserModel user = UserModel.fromJson(userString);
        return user;
      } else {
        throw ('User not authenticated');
      }
    } catch (e) {
      throw (e.toString());
    }
  }
}
