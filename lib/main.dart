import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/autentication/auth_provider.dart';
import 'core/autentication/configurations/authentication_configurations.dart';
import 'core/authorities/authority_provider.dart';
import 'core/connectivity/connectivity.dart';
import 'core/env/env.manager.dart';
import 'core/language/it.dart';
import 'core/notifications/notification_service.dart';
import 'core/providers/providers.dart';
import 'core/routing/routing.dart';
import 'core/storage/stotage_keys.dart';
import 'ui/pages/load.dart';

// ADDING FIREBASE

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LoadPage());
  // await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await EnvManager.init();
  await ConnectivityProvider.init();
  await AuthProvider.init(
    configurations: AuthenticationConfigurations.authConfigurations,
    listenable: (data) async {
      try {
        if (data.userData.UserId != null && data.authData.accessToken != null) {
          await AuthorityProvider().fetchAuthorities();
          await NotificationService.create(
            userId: data.userData.UserId!,
            foregroundMessage: ItL.newNotificationRecived,
          );
        }
      } catch (e) {
        return;
      }
    },
    storageKey: StorageKeys.authenticationKey,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = Routing(
      authProvider: AuthProvider(),
      connectivityProvider: ConnectivityProvider(),
    );
    return MultiProvider(
      providers: AppProviders.providers,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: ItL.appTitle,
        theme: ThemeData(),
        routeInformationProvider: router.goRouter.routeInformationProvider,
        routeInformationParser: router.goRouter.routeInformationParser,
        routerDelegate: router.goRouter.routerDelegate,
      ),
    );
  }
}
