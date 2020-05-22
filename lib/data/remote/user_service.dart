import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_shop/network/auth_client.dart';

const String _apiKey = 'AIzaSyCeTMKY5Gtxs5D2wQeSlOuDxPHYHDnpaOg';

class UserService {
  Future<Response> signUp(String email, String password) {
    debugPrint('$email $password');
    return AuthClient.instance.dio.post(
      'accounts:signUp?key=$_apiKey',
      data: {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      },
    );
  }
}
