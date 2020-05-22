import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

const String _kBaseUrl = 'https://identitytoolkit.googleapis.com/v1/';

class AuthClient {
  AuthClient._internal() {
    debugPrint('init AuthClient');
  }

  static final BaseOptions _options = BaseOptions(
    baseUrl: _kBaseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  static final Dio _dio = Dio(_options);

  static final AuthClient instance = AuthClient._internal();

  Dio get dio => _dio;
}
