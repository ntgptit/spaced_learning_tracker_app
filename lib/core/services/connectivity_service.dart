import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Connectivity service
/// Handles network connectivity state and changes
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late StreamController<bool> _connectionChangeController;

  bool _hasConnection = true;

  Stream<bool> get connectionChange => _connectionChangeController.stream;

  bool get hasConnection => _hasConnection;

  ConnectivityService() {
    _connectionChangeController = StreamController<bool>.broadcast();
    _initConnectivity();
    _setupConnectivityListener();
  }

  /// Initialize connectivity state
  Future<void> _initConnectivity() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    _hasConnection = _isConnected(connectivityResult);
    _connectionChangeController.add(_hasConnection);
  }

  /// Setup connectivity change listener
  void _setupConnectivityListener() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      final hasConnection = _isConnected(result);

      if (_hasConnection != hasConnection) {
        _hasConnection = hasConnection;
        _connectionChangeController.add(hasConnection);
      }
    });
  }

  /// Check if connection is available based on connectivity result
  bool _isConnected(ConnectivityResult connectivityResult) {
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet;
  }

  /// Check connectivity
  Future<bool> checkConnectivity() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    _hasConnection = _isConnected(connectivityResult);
    return _hasConnection;
  }

  /// Dispose the service
  void dispose() {
    _connectionChangeController.close();
  }
}
