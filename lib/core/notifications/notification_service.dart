import 'package:shared_preferences/shared_preferences.dart';
import '../storage/stotage_keys.dart';
import 'fcm.dart';
import 'register_notification_hub.dart';

class NotificationService {
  // NotificationService.init({required this.authProvider}) {
  //   _init();
  // }
  final String userId;
  final String foregroundMessage;

  NotificationService._create(
      {required this.userId, required this.foregroundMessage}) {
    // init code here
  }

  Future<SharedPreferences> get _storage async {
    return await SharedPreferences.getInstance();
  }

  String get storageKey {
    return StorageKeys.notificationHubKey;
  }

  static Future<NotificationService> create(
      {required String userId, required String foregroundMessage}) async {
    // Call the private constructor
    final notificationService = NotificationService._create(
        userId: userId, foregroundMessage: foregroundMessage);

    // notificationService._instanceFcm = FCM(foregroungMessage);
    // Do initialization that requires async
    await notificationService.enableNotifications(userId);
    // Return the fully initialized object
    return notificationService;
  }

  late final FCM _instanceFcm = FCM(foregroundMessage);
  final RegisterNotificationHub _instanceNotificationHub =
      RegisterNotificationHub();

  Future<void> enableNotifications(String userId) async {
    await _instanceFcm.enable();
    return await _instanceNotificationHub.register(
      userId: userId,
      storage: await _storage,
      storageKey: storageKey,
    );
  }
}
