import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/pages/authority_select.dart';
import '../../ui/pages/connection_error.dart';
import '../../ui/pages/errors/error_page.dart';
import '../../ui/pages/not_logging_page.dart';
import '../../ui/pages/unauthorized_page.dart';
import '../../ui/widgets/navigation/navigation.dart';
import '../../ui/widgets/page.dart';
import '../autentication/auth_provider.dart';
import '../connectivity/connectivity.dart';
import '../providers/base_provider.dart';
import 'configurations/configurations.dart';

class Routing {
  final AuthProvider authProvider;
  final ConnectivityProvider connectivityProvider;
  Routing({
    required this.authProvider,
    required this.connectivityProvider,
  }) {
    initListeners();
  }

  final BaseProvider _baseProvider = BaseProvider();

  final pages = {
    Routes.homeN: const SizedBox(),
    Routes.profileN: const SizedBox(),
    Routes.favoritesN: const SizedBox(),
  };

  late final goRouter = GoRouter(
    refreshListenable: _baseProvider,
    debugLogDiagnostics: true,
    urlPathStrategy: UrlPathStrategy.path,
    initialLocation: Routes.root,
    routes: [
      GoRoute(
        name: Routes.rootN,
        path: Routes.root,
        redirect: (state) => state.namedLocation(
          Routes.tabN,
          params: {Routes.tabN: Routes.homeN},
        ),
      ),
      GoRoute(
        name: Routes.tabN,
        path:
            '${Routes.tab}/:${Routes.tabN}(${Routes.homeN}|${Routes.favoritesN}|${Routes.profileN})',
        builder: (context, state) {
          final tab = state.params[Routes.tabN] ?? '';
          return Navigation(
            home: pages[Routes.homeN]!,
            profile: pages[Routes.profileN]!,
            favorites: pages[Routes.favoritesN]!,
            defaultRouteName: Routes.homeN,
            favoritesRouteName: Routes.favoritesN,
            homeRouteName: Routes.homeN,
            profileRouteName: Routes.profileN,
            routeName: tab,
          );
        },
        routes: [
          GoRoute(
            name: Routes.authoritySelectN,
            path: Routes.authoritySelect,
            builder: (context, state) {
              return const AuthoritySelect();
            },
          ),
        ],
      ),
      GoRoute(
        name: Routes.homeN,
        path: Routes.home,
        redirect: (state) => state.namedLocation(
          Routes.tabN,
          params: {Routes.tabN: Routes.homeN},
        ),
      ),
      GoRoute(
        name: Routes.profileN,
        path: Routes.profile,
        redirect: (state) => state.namedLocation(
          Routes.tabN,
          params: {Routes.tabN: Routes.profileN},
        ),
      ),
      GoRoute(
        name: Routes.favoritesN,
        path: Routes.favorites,
        redirect: (state) => state.namedLocation(
          Routes.tabN,
          params: {Routes.tabN: Routes.favoritesN},
        ),
      ),
      GoRoute(
        name: Routes.loginN,
        path: Routes.login,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        name: Routes.connectionN,
        path: Routes.connection,
        builder: (context, state) {
          return const ConnectionError();
        },
      ),
      GoRoute(
        name: Routes.unauthorizedN,
        path: Routes.unauthorized,
        builder: (context, state) {
          return const UnauthorizedPage();
        },
      ),
      GoRoute(
        name: Routes.communicationN,
        path: '${Routes.communication}/:communicationId',
        pageBuilder: (context, state) {
          final int? communicationId =
              int.tryParse(state.params['communicationId'] ?? '');
          if (communicationId == null) {
            throw Exception("communicationId Empty");
          }
          return const PageI<void>(
            child: SizedBox(),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) => const PageI<void>(child: ErrorPage()),
    errorBuilder: (context, state) => const ErrorPage(),
    redirect: (state) {
      final loggedIn = authProvider.currentIsAuth;
      final isConnect = connectivityProvider.isConnect;
      final isAuthorized = authProvider.isAuthorized;

      // connectivity
      if (isConnect == false && state.subloc != Routes.connection) {
        return state.namedLocation(Routes.connectionN);
      }

      if (isConnect == true && state.subloc == Routes.connection) {
        return state.namedLocation(Routes.rootN);
      }
      // end
      // route unauthorized
      if (/* loggedIn == true && */
          isAuthorized == false && state.subloc != Routes.unauthorized) {
        return state.namedLocation(Routes.unauthorizedN);
      }

      if (/* loggedIn == true && */
          isAuthorized != false && state.subloc == Routes.unauthorized) {
        return state.namedLocation(Routes.rootN);
      }
      // end
      // route login
      if (loggedIn == false && state.subloc != Routes.login) {
        return state.namedLocation(Routes.loginN);
      }
      if (loggedIn == true && state.subloc == Routes.login) {
        return state.namedLocation(Routes.rootN);
      }
      // end

      return null;
    },
  );

  void initListeners() {
    connectivityProvider.addListener(() {
      return _baseProvider.notify();
    });
    authProvider.addListener(() {
      return _baseProvider.notify();
    });
  }
}
