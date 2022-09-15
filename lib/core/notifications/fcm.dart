import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../ui/widgets/toast/toast.dart';

Future<void> backgroundMessageHandler(/* RemoteMessage message */) async {
  /* await Firebase.initializeApp();
  if (kDebugMode) {
    print("nuovo messaggio riceviuto in background");
  } */
  return;
}

class FCM extends ChangeNotifier {
  FCM._create(this.foregroundMessage);

  static FCM? _instance;

  static FCM get intance =>
      _instance ??
      FCM(_instance?.foregroundMessage ?? "Nuovo messaggio ricevuto");

  factory FCM(String foregroundMessage) {
    if (_instance == null) {
      _instance = FCM._create(foregroundMessage);
      return _instance!;
    }
    return _instance!;
  }

  void notify() {
    notifyListeners();
  }

  final String foregroundMessage;

  Future<void> enable() async {
    try {
      /* final settings =
          await FirebaseMessaging.instance.getNotificationSettings();

      FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

      if (kDebugMode) {
        print('settings => $settings');
      }

      final requestPermissions =
          await FirebaseMessaging.instance.requestPermission();

      if (kDebugMode) {
        print('settings => $requestPermissions');
      }

      FirebaseMessaging.onMessageOpenedApp.listen((message) async {});

      FirebaseMessaging.onMessage.listen((message) async {
        notify();
        await createLocalNotification(message);
      });
      // if (Platform.isIOS) {
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      // }
      //FirebaseMessaging.instance.subscribeToTopic(topic);

      FirebaseMessaging.onMessageOpenedApp.listen((message) async {
        if (kDebugMode) {
          print('On Message Opened App => ${message.data}');
        }
      }); */
    } catch (e) {
      if (kDebugMode) {
        print('Error EnableFCM => $e');
      }
    }
  }

  Future<void> createLocalNotification(/* RemoteMessage message */) async {
    try {
      if (kDebugMode) {
        print("nuovo messaggio riceviuto");
      }
      if (Platform.isAndroid) {
        final localNotification = FlutterLocalNotificationsPlugin();

        const AndroidNotificationDetails androidDetails =
            AndroidNotificationDetails(
          'foreground_notification_channel',
          'Notification',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          icon: "smartpaelezioni",
          playSound: true,
        );

        const initializationSettingsAndroid =
            AndroidInitializationSettings('smartpaelezioni');

        const initializationSettings =
            InitializationSettings(android: initializationSettingsAndroid);

        // ignore: unused_local_variable
        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidDetails);

        await localNotification.initialize(initializationSettings);

        /* await localNotification.show(
          message.notification?.hashCode ?? message.hashCode,
          message.notification?.title ?? 'non definito',
          message.notification?.body ?? 'non definito',
          platformChannelSpecifics,
        ); */
      }
    } catch (e) {
      return ShowToast.showToast(foregroundMessage);
    }
  }
}
