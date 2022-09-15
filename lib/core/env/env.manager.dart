import 'dart:convert';
import 'package:flutter/services.dart';
import 'models/base_config.dart';

class EnvManager implements BaseConfig {
  EnvManager._create();

  static Future<EnvManager> init() async {
    _instance = EnvManager._create();

    _instance?._configurations = await _instance!._fetchFireBaseConfiguration();
    _instance?._test();
    return _instance!;
  }

  static EnvManager? _instance;

  factory EnvManager() {
    if (_instance != null) {
      return _instance!;
    }
    throw Exception("EnvManager not initialized");
  }

  Map<String, dynamic> _configurations = {};

  dynamic _getObj(Map<String, dynamic> configurations, String key) {
    return configurations[key];
  }

  Future<Map<String, dynamic>> _fetchFireBaseConfiguration() async {
    /* await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 3),
      minimumFetchInterval: const Duration(hours: 6),
    ));

    await FirebaseRemoteConfig.instance.setDefaults(await _fetchJsonProd());

    await FirebaseRemoteConfig.instance.fetchAndActivate(); */

    // const defaultEnv = kReleaseMode ? 'prod' : 'dev';

    /* final env =
        const String.fromEnvironment("ENVIRONMENT", defaultValue: defaultEnv)
            .toLowerCase(); */

    /* final configurations = jsonDecode(FirebaseRemoteConfig.instance
        .getValue('${env}_appconfig_smartpa')
        .asString()); */
    final configurations = await _fetchJsonProd();

    return configurations;
  }

  Future<Map<String, dynamic>> _fetchJsonProd() async {
    return (await json
                .decode(await rootBundle.loadString('assets/envs/prod.json'))
            as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, jsonEncode(value)));
  }

  void _test() {
    final List<dynamic> conf = [
      envName,
      baseUrl,
      baseUrlCore,
      loginBaseUrl,
      baseUrlProfile,
      loginScopes,
      tenantId,
      clientId,
      redirectUrl,
      issuer,
      discoveryUrl,
      postLogOutRedirectUrl,
      authorizationEndpoint,
      tokenEndpoint,
      endSessionPoint,
      privacyUrl,
      notificationHubUserAgent,
    ];

    for (var element in conf) {
      if (element.isEmpty) {
        throw Exception("check configurations => $conf");
      }
    }
  }

  @override
  String get baseUrl => _getObj(_configurations, "base_url");
  @override
  String get baseUrlCore => _getObj(_configurations, "base_url_core");

  @override
  String get clientId => _getObj(_configurations, "clientId");

  @override
  String get discoveryUrl => _getObj(_configurations, "discoveryUrl");

  @override
  String get endSessionPoint => _getObj(_configurations, "endSessionPoint");

  @override
  String get authorizationEndpoint =>
      _getObj(_configurations, "authorization_endpoint");

  @override
  String get issuer => _getObj(_configurations, "issuer");

  @override
  String get loginBaseUrl => _getObj(_configurations, "login_base_url");

  @override
  List<String> get loginScopes =>
      List<String>.from(_getObj(_configurations, "login_scopes") as List);

  @override
  String get envName => _getObj(_configurations, "envname");

  @override
  String get postLogOutRedirectUrl =>
      _getObj(_configurations, "postLogOutRedirectUrl");

  @override
  String get redirectUrl => _getObj(_configurations, "redirectUrl");

  @override
  String get tenantId => _getObj(_configurations, "tenantId");

  @override
  String get tokenEndpoint => _getObj(_configurations, "tokenEndpoint");

  @override
  String get privacyUrl => _getObj(_configurations, "privacy_url");

  @override
  String get notificationHubUserAgent =>
      _getObj(_configurations, "notification_hub_user_agent");

  @override
  String get baseUrlProfile => _getObj(_configurations, "base_url_profile");

  @override
  Map<String, dynamic> get loginAdditionalParameter =>
      _getObj(_configurations, "loginAdditionalParameter");
}
