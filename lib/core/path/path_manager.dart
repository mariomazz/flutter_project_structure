import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PathManager {
  static Future<String> getMainDirectory(String basename) async {
    if (kIsWeb) {
      throw Exception("Unsupported Platform");
    }
    if (Platform.isAndroid) {
      return "/storage/emulated/0/Download/$basename";
    }
    if (Platform.isIOS) {
      return (await getApplicationDocumentsDirectory()).path;
    }
    throw Exception("Unsupported Platform");
  }

  String? getMimeType(String path) {
    return lookupMimeType(path);
  }

  String getBasename(String path) {
    return basename(path);
  }
}
