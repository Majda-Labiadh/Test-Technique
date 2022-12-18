import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  Connectivity dataConnectionChecker;

  NetworkInfoImpl(this.dataConnectionChecker);
  Future<bool> checkConnection() async {
    var isOnline = await (Connectivity().checkConnectivity());
    bool isConnected;
    if (isOnline == ConnectivityResult.none) {
      isConnected = false;
    } else {
      isConnected = true;
    }
    return isConnected;
  }

  @override
  Future<bool> get isConnected => checkConnection();
}
