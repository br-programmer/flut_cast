import 'dart:io';

import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required String apiKey})
      : _queryParameters = {'appid': apiKey};

  final Map<String, dynamic> _queryParameters;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters
      ..addAll(_queryParameters)
      ..addAll(
        {
          'lang': Platform.localeName.substring(0, 2),
          'units': 'metric',
        },
      );
    super.onRequest(options, handler);
  }
}
