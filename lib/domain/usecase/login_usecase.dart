import 'package:dartz/dartz.dart';
import 'package:test_app/app/functions.dart';
import 'package:test_app/data/network/failure.dart';
import 'package:test_app/data/request/request.dart';
import 'package:test_app/domain/model/model.dart';
import 'package:test_app/domain/repository/repository.dart';
import 'package:test_app/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Faliure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo _deviceInfo = await getDeviceDetails();
    return await _repository.login(LoginRequest(
        input.email, input.password, _deviceInfo.identifire, _deviceInfo.name));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
