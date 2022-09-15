import 'dart:convert';
import 'package:dio/dio.dart';
import '../autentication/auth_provider.dart';
import '../authorities/authority_provider.dart';
import '../env/env.manager.dart';
import 'api_interceptor.dart';
import 'models/content_type.dart';
import 'models/header_type.dart';
import 'models/http_request.dart';
import 'models/json_serializable.dart';

class Http {
  static final Http _instance = Http._singleton();
  final _baseUrl = EnvManager().baseUrl;

  Http._singleton() {
    _init();
  }

  factory Http() {
    return _instance;
  }

  final Dio _dio = Dio();

  void _init() {
    return _dio.interceptors.add(HttpInterceptor(client: _dio));
  }

  Future<Response> get({required HttpRequestBase req}) async {
    return await _dio.get(
      req.baseUrl ? (_baseUrl + req.point) : req.point,
      queryParameters: req.queryParameters,
      options: Options(
        headers: _getHeader(
          headerType: req.headerType,
          headerExtra: req.headerExtra,
          content: req.content,
        ),
      ),
    );
  }

  Future<Response<T>> getDataParsed<T extends JsonSerializable>(
      {required HttpRequestBase req}) async {
    final response = await _dio.get(
      req.baseUrl ? (_baseUrl + req.point) : req.point,
      queryParameters: req.queryParameters,
      options: Options(
        headers: _getHeader(
          headerType: req.headerType,
          headerExtra: req.headerExtra,
          content: req.content,
        ),
      ),
    );
    if (T is! JsonSerializable) {
      return Response(
        data: response.data,
        headers: response.headers,
        requestOptions: response.requestOptions,
        isRedirect: response.isRedirect,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        redirects: response.redirects,
        extra: response.extra,
      );
    }
    return Response<T>(
      data: JsonSerializable.fromMap<T>(response.data),
      headers: response.headers,
      requestOptions: response.requestOptions,
      isRedirect: response.isRedirect,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      redirects: response.redirects,
      extra: response.extra,
    );
  }

  Future<Response> post({required HttpRequestBase req}) async {
    return await _dio.post(
      req.baseUrl ? (_baseUrl + req.point) : req.point,
      data: req.dataJsonEncode ? jsonEncode(req.data) : req.data,
      queryParameters: req.queryParameters,
      options: Options(
        headers: _getHeader(
          headerType: req.headerType,
          headerExtra: req.headerExtra,
          content: req.content,
        ),
      ),
    );
  }

  Future<Response> put({required HttpRequestBase req}) async => await _dio.put(
        req.baseUrl ? (_baseUrl + req.point) : req.point,
        data: req.dataJsonEncode ? jsonEncode(req.data) : req.data,
        queryParameters: req.queryParameters,
        options: Options(
          headers: _getHeader(
            headerType: req.headerType,
            headerExtra: req.headerExtra,
            content: req.content,
          ),
        ),
      );

  Future<Response> delete({required HttpRequestBase req}) async =>
      await _dio.delete(
        req.baseUrl ? (_baseUrl + req.point) : req.point,
        data: req.dataJsonEncode ? jsonEncode(req.data) : req.data,
        queryParameters: req.queryParameters,
        options: Options(
          headers: _getHeader(
            headerType: req.headerType,
            headerExtra: req.headerExtra,
            content: req.content,
          ),
        ),
      );

  Future<Response> download({required HttpRequestDownloadingFile req}) async =>
      await _dio.download(
        req.baseUrl ? (_baseUrl + req.point) : req.point,
        req.savePath,
        data: req.dataJsonEncode ? jsonEncode(req.data) : req.data,
        queryParameters: req.queryParameters,
        options: Options(
          headers: _getHeader(
            headerType: req.headerType,
            headerExtra: req.headerExtra,
            content: req.content,
          ),
        ),
      );

  Map<String, String> _getHeader({
    HeaderType headerType = HeaderType.authorizeAuthority,
    Map<String, String> headerExtra = const {},
    ContentTypeI? content,
  }) {
    switch (headerType) {
      case HeaderType.authorizeAuthority:
        return _authorizeAuthorityHeader(
            headerExtra: headerExtra, content: content);
      case HeaderType.authorize:
        return _authorizeHeader(headerExtra: headerExtra, content: content);
      case HeaderType.notAuthorize:
        return _notAuthorizedHeader(headerExtra: headerExtra, content: content);
      default:
        return _notAuthorizedHeader(headerExtra: headerExtra, content: content);
    }
  }

  Map<String, String> _notAuthorizedHeader({
    Map<String, String> headerExtra = const {},
    ContentTypeI? content,
  }) {
    final header = <String, String>{};
    header.addAll(headerExtra);
    if (content != null) {
      header.addAll(content.getHeader());
    }
    return header;
  }

  Map<String, String> _authorizeHeader({
    Map<String, String> headerExtra = const {},
    ContentTypeI? content,
  }) {
    final header = <String, String>{};
    header.addAll(headerExtra);
    if (content != null) {
      header.addAll(content.getHeader());
    }
    final String? accessToken = AuthProvider().currentAccessToken;
    if (accessToken != null) {
      header.addAll({'Authorization': 'Bearer $accessToken'});
    }
    return header;
  }

  Map<String, String> _authorizeAuthorityHeader({
    Map<String, String> headerExtra = const {},
    ContentTypeI? content,
  }) {
    final headerBase = _authorizeHeader(headerExtra: headerExtra);
    if (content != null) {
      headerBase.addAll(content.getHeader());
    }
    final int? authority = AuthorityProvider().authorityId;
    if (authority != null) {
      headerBase.addAll({
        "AuthorityId": authority.toString(),
      });
    }
    return headerBase;
  }
}
