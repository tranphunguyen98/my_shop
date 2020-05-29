import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_shop/data/remote/user_service.dart';

class UserRepo {
  final UserService _userService;

  UserRepo({@required UserService userService}) : _userService = userService;

  Future<String> signUp(String email, String pass) async {
    debugPrint('signUp');
    final c = Completer<String>();
    try {
      final response = await _userService.signUp(email, pass);
      debugPrint('reponse: ${response.data ?? 'null le'}');
      if (response.data != null) {
        debugPrint('data: ${response.data}');
        c.complete(response.data['data'].toString());
      }

      // var userData = UserData.fromJson(response.data['data']);
      // if (userData != null) {
      //   SPref.instance.set(SPrefCache.KEY_TOKEN, userData.token);
      //   c.complete(userData);
      // }

    } on DioError catch (e) {
      c.completeError('Đăng ký thất bại ${e.response}');
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }

  Future<String> signIn(String email, String pass) async {
    debugPrint('signIn');
    final c = Completer<String>();
    try {
      final response = await _userService.signIn(email, pass);
      debugPrint('reponse: ${response.data ?? 'null le'}');
      if (response.data != null) {
        debugPrint('data: ${response.data}');
        c.complete(response.data['data'].toString());
      }

      // var userData = UserData.fromJson(response.data['data']);
      // if (userData != null) {
      //   SPref.instance.set(SPrefCache.KEY_TOKEN, userData.token);
      //   c.complete(userData);
      // }

    } on DioError catch (e) {
      c.completeError('Đăng nhập thất bại ${e.response}');
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }
}

class UserData {}
