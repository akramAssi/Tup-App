import 'package:test_app/data/network/app_api.dart';
import 'package:test_app/data/request/request.dart';
import 'package:test_app/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementer extends RemoteDataSource {
  final AppServicesClient _appServicesClient;

  RemoteDataSourceImplementer(this._appServicesClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServicesClient.login(
      loginRequest.email,
      loginRequest.password,
      loginRequest.imei,
      loginRequest.deviceType,
    );
  }
}
