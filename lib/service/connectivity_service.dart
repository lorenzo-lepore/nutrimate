import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  final InternetConnectionChecker _connectionChecker = InternetConnectionChecker();
  
  Stream<bool> get connectivityStream => _connectionChecker.onStatusChange
      .map((status) => status == InternetConnectionStatus.connected);

  Future<bool> get isConnected => _connectionChecker.hasConnection;
}