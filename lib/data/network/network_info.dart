import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnection;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker _dataConnectionChecker;

  NetworkInfoImpl(this._dataConnectionChecker);

  @override
  // TODO: implement isConnection
  Future<bool> get isConnection => _dataConnectionChecker.hasConnection;
}
