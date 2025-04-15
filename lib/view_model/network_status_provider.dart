

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkStatusProvider extends ChangeNotifier{

  bool _isOnline = true;

  bool get isOnline => _isOnline;

  NetworkStatusProvider() {
    _monitorNetworkStatus();
  }

  void _monitorNetworkStatus() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> statusList) {
      _isOnline = !statusList.contains(ConnectivityResult.none);
      notifyListeners();
    });
  }
}