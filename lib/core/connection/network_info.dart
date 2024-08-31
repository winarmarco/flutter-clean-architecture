import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfo(this._connectivity);

  Future<bool> isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}
