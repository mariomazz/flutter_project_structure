import 'content_type.dart';
import 'header_type.dart';

class HttpRequestBase {
  final String point;
  final bool baseUrl;
  final bool dataJsonEncode;
  final ContentTypeI? content;
  final HeaderType headerType;
  final Map<String, String> headerExtra;
  final dynamic data;
  final Map<String, dynamic>? queryParameters;

  HttpRequestBase({
    required this.point,
    this.baseUrl = true,
    this.dataJsonEncode = false,
    this.content,
    this.headerType = HeaderType.authorizeAuthority,
    this.headerExtra = const {},
    this.data,
    this.queryParameters,
  });
}

class HttpRequestDownloadingFile extends HttpRequestBase {
  final String savePath;
  HttpRequestDownloadingFile({
    required this.savePath,
    required HttpRequestBase request,
  }) : super(
          point: request.point,
          baseUrl: request.baseUrl,
          dataJsonEncode: request.dataJsonEncode,
          content: request.content,
          headerType: request.headerType,
          headerExtra: request.headerExtra,
          data: request.data,
          queryParameters: request.queryParameters,
        );
}
