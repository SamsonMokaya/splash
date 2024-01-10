// ignore_for_file: body_might_complete_normally_nullable

import '../models/user.dart';

abstract class BaseAuthRepository {
  Future<UserModel?> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String admisionNumber,
  }) async {}
  Future<UserModel?> login(
      {required String email, required String password}) async {}
  Future<UserModel?> checkUser() async {}
  Future<bool?> logOut() async {}
}
