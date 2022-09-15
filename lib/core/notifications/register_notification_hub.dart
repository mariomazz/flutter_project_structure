import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/models/noticationhub_write.dart';
import '../common/models/notificationhub_base.dart';
import '../env/env.manager.dart';
import '../http/http_service.dart';
import '../http/models/content_type.dart';
import '../http/models/header_type.dart';
import '../http/models/http_request.dart';

class RegisterNotificationHub {
  RegisterNotificationHub();

  Future<void> register({
    required String userId,
    required String storageKey,
    required SharedPreferences storage,
  }) async {
    const String? token = null;
    /* final token = Platform.isIOS
        ? (await FirebaseMessaging.instance.getAPNSToken())
        : Platform.isAndroid
            ? (await FirebaseMessaging.instance.getToken())
            : null; */

    final reId = storage.getString(storageKey);
    if (token == null) {
      throw Exception("FCM TOKEN null");
    }

    final register = await _registerNotificationHub(
      NotificationhubWrite(
        installationId: token,
        platform: Platform.isIOS ? 'apns' : 'gcm',
        registrationId: reId ?? '',
        tags: ['User_15_$userId'],
      ),
    );

    await storage.setString(storageKey, register.registrationId);
    return;
  }

  Future<NotificationhubBase> _registerNotificationHub(
      NotificationhubWrite data) async {
    final String coreApi = EnvManager().baseUrlCore;

    final response = await Http().put(
      req: HttpRequestBase(
        point: '${coreApi}notificationhub/registerorupdate',
        baseUrl: false,
        data: data.toMap(),
        content: ContentTypeI.json,
        headerType: HeaderType.authorize,
        headerExtra: {'X-User-Agent': EnvManager().notificationHubUserAgent},
      ),
    );

    return NotificationhubBase.fromMap(response.data);
  }
}
