import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenBrowser {
  static Future<void> open(String? url,
      {bool androidExternalLaunch = true}) async {
    if (url != null) {
      if (kIsWeb) {
        await launchUrl(Uri.parse(url));
        return;
      }
      if (Platform.isAndroid) {
        await launchUrl(
          Uri.parse(url),
          mode: androidExternalLaunch
              ? LaunchMode.externalApplication
              : LaunchMode.platformDefault,
        );
        return;
      }
      await launchUrl(Uri.parse(url));
    } else {
      log('url null riprova');
    }
  }
}
