import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'models/connectivity_result.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityProvider._create();

  static ConnectivityProvider? _instance;

  static Future<ConnectivityProvider> init() async {
    _instance = ConnectivityProvider._create();
    await _instance?._initializeConnectivity();
    return _instance!;
  }

  factory ConnectivityProvider() {
    if (_instance != null) {
      return _instance!;
    }
    throw Exception();
  }

  ConnectivityResultCS? _connectivityStatus;

  ConnectivityResultCS? get status => _connectivityStatus;

  bool get isConnect =>
      status == ConnectivityResultCS.ethernet ||
      status == ConnectivityResultCS.mobile ||
      status == ConnectivityResultCS.wifi;

  final _connectivity = Connectivity();

  Future<void> _initializeConnectivity() async {
    _setStatus(await checkConnectivity());
    _connectivity.onConnectivityChanged.listen((data) {
      _setStatus(data);
    });
  }

  void _setStatus(ConnectivityResult status) {
    _connectivityStatus = _from(status);
    notifyListeners();
  }

  Future<ConnectivityResult> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup(
          'www.google.com'); // google address for validity issues
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return await _connectivity.checkConnectivity();
      }
      throw Exception();
    } on SocketException catch (_) {
      return ConnectivityResult.none;
    } catch (e) {
      return ConnectivityResult.none;
    }
  }

  ConnectivityResultCS _from(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.bluetooth:
        return ConnectivityResultCS.bluetooth;
      case ConnectivityResult.ethernet:
        return ConnectivityResultCS.ethernet;
      case ConnectivityResult.wifi:
        return ConnectivityResultCS.wifi;
      case ConnectivityResult.mobile:
        return ConnectivityResultCS.mobile;
      default:
        return ConnectivityResultCS.none;
    }
  }
}
