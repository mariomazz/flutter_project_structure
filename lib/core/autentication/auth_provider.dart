import 'package:flutter/material.dart';
import 'package:platforms_auth_service/platforms_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/common.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider._create();

  static AuthProvider? _instance;

  static Future<AuthProvider> init(
      {required AuthConfigurations configurations,
      Future<void> Function(AuthUserData data)? listenable,
      required String storageKey}) async {
    _instance = AuthProvider._create();
    _instance?._dbLoginKey = storageKey;
    _instance?._configurations = configurations;
    _instance?.listenable = listenable;
    final currentSession = await _instance!.loadSession();
    _instance?._setSession(currentSession);
    await _instance?.listenable?.call(currentSession);

    return _instance!;
  }

  factory AuthProvider() {
    if (_instance != null) {
      return _instance!;
    }
    throw Exception("AuthProvider not initialized");
  }

  late final AuthConfigurations _configurations;

  late final Future<void> Function(AuthUserData data)? listenable;

  late final _authService = AuthService(
    configurations: _configurations,
    storageInstance: SharedPreferences.getInstance(),
    authDbKey: _dbLoginKey,
  );

  late final String _dbLoginKey;

  final _sessionNull = AuthUserData(
    authData: AuthData(isAuth: false),
    userData: UserData(),
  );

  late AuthUserData _session;

  bool? _isAuthorized;
  bool? get isAuthorized => _isAuthorized;

  AuthUserData get current => _session;

  String? get currentAccessToken => current.authData.accessToken;

  bool get currentIsAuth => current.authData.isAuth;

  Future<AuthUserData> loadSession() async {
    try {
      final loginData = await _authService.getTokensSaved();
      final String accessToken = loginData.accessToken;
      final auth = AuthData(
        isAuth: true,
        accessToken: accessToken,
      );
      return AuthUserData.from(
        authData: auth,
        userData: _getUserData(accessToken),
      );
    } catch (e) {
      return _sessionNull;
    }
  }

  Future<void> refreshSession() async {
    try {
      final authData = await _authService.refreshSession();
      final accessToken = authData.accessToken;
      final refreshData = AuthUserData.from(
        authData: authData,
        userData: accessToken != null ? _getUserData(accessToken) : UserData(),
      );
      _setSession(refreshData);
      _setAuthorization(true);
      await _instance?.listenable?.call(refreshData);
      _updateUI();
      return;
    } catch (e) {
      return;
    }
  }

  Future<void> login() async {
    final authData = await _authService.login();
    final accessToken = authData.accessToken;
    final loginData = AuthUserData.from(
      authData: authData,
      userData: accessToken != null ? _getUserData(accessToken) : UserData(),
    );
    _setSession(loginData);
    _setAuthorization(true);
    await _instance?.listenable?.call(loginData);
    _updateUI();
  }

  Future<void> logout() async {
    await _authService.logout();
    _setSession(_sessionNull);
    _setAuthorization(null);
    await _instance?.listenable?.call(_sessionNull);
    _updateUI();
  }

  void setAuthorization(bool? authorized) {
    _setAuthorization(authorized, notify: true);
  }

  void _setAuthorization(bool? authorized, {bool notify = false}) {
    _isAuthorized = authorized;
    if (notify) {
      _updateUI();
    }
  }

  void _setSession(AuthUserData data, {bool notify = false}) {
    _session = data;
    if (notify) {
      _updateUI();
    }
  }

  UserData _getUserData(String accessToken) {
    return UserData.fromMap(_authService.decodeToken(accessToken));
  }

  void _updateUI() {
    return notifyListeners();
  }
}
