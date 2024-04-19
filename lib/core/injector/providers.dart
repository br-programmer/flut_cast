import 'package:dio/dio.dart';
import 'package:fc_api_client/fc_api_client.dart';
import 'package:flut_cast/core/core.dart';
import 'package:riverpod/riverpod.dart';

class Providers {
  const Providers._();
  static final enviroment = Provider<Environment>(
    (ref) => throw UnimplementedError(),
  );

  static final fcApi = Provider<Http>(
    (ref) {
      final env = ref.read(enviroment);
      final enableLogging = env.enableLogging;
      final dio = Dio(BaseOptions(baseUrl: env.baseUrl));
      dio.interceptors.addAll([
        RetryInterceptor(dio: dio, enableLogging: enableLogging),
        AuthInterceptor(apiKey: env.apiKey),
      ]);
      return Http(dio: dio, enableLogging: enableLogging);
    },
  );
}
