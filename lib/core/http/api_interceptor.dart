import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../autentication/auth_provider.dart';

class HttpInterceptor extends Interceptor {
  late Dio _client;
  HttpInterceptor({
    required Dio client,
  }) {
    _client = client;
  }

  final AuthProvider authProvider = AuthProvider();
  int retryCounter = 0;
  final int retryLimit = 5;
  get retryValid {
    return retryCounter <= retryLimit;
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {
      print(
          'REQUEST[${options.method}] => PATH: ${options.path} => [${options.queryParameters}]');
      print(options.data);
      log('HEADERS : ${options.headers}');
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (kDebugMode) {
      print(
          'RESPONSE[${response.requestOptions.path}] => BODY: ${response.data}');
    }

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      print(
          'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
      print(err.response?.data);
    }

    switch (err.response?.statusCode) {
      case 401:
        retryCounter++;

        if (err.requestOptions.headers['Authorization'] != null && retryValid) {
          await authProvider.refreshSession();
          final String? accessToken = authProvider.currentAccessToken;
          err.requestOptions.headers['Authorization'] =
              accessToken != null ? 'Bearer $accessToken' : "";

          await _retryRequest(err.requestOptions, handler);
        }
        break;
      case 403:
        authProvider.setAuthorization(false);
        break;
      default:
        break;
    }

    return super.onError(err, handler);
  }

  Future<void> _retryRequest(
    RequestOptions requestOptions,
    ErrorInterceptorHandler handler,
  ) async {
    final response = await _client.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      ),
    );
    return handler.resolve(response);
  }
}
