import 'dart:async';

import 'package:test_app/domain/usecase/login_usecase.dart';
import 'package:test_app/presentation/base/base_viewmodel.dart';
import 'package:test_app/presentation/commen/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  final StreamController<String> _usernameStreamControlller =
      StreamController<String>.broadcast();
  final StreamController<String> _passwordStreamControlller =
      StreamController<String>.broadcast();
  final StreamController<void> _allInputIsValidStreamControlller =
      StreamController<void>.broadcast();
  LoginObject loginObject = LoginObject("", "");

  final LoginUseCase? _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _usernameStreamControlller.close();
    _passwordStreamControlller.close();
    _allInputIsValidStreamControlller.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamControlller.sink;

  @override
  Sink get inputUserName => _usernameStreamControlller.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAllInputIsValid.add(null);
  }

  @override
  setUserName(String username) {
    inputUserName.add(username);
    loginObject = loginObject.copyWith(username: username);
    inputAllInputIsValid.add(null);
  }

  @override
  login() async {
    var result = await _loginUseCase?.execute(
        LoginUseCaseInput(loginObject.username, loginObject.password));
    result?.fold((faliuer) => {print(faliuer.messsage)},
        (authentiction) => {print(authentiction.customer?.name)});
  }

  @override
  Stream<bool> get outputPasswordValid => _passwordStreamControlller.stream
      .map((password) => _isValidPassword(password));

  @override
  Stream<bool> get outputUserNameValid => _usernameStreamControlller.stream
      .map((username) => _isValidUsername(username));

  bool _isValidPassword(String password) {
    return password.isNotEmpty;
  }

  bool _isValidUsername(String username) {
    return username.isNotEmpty;
  }

  bool _isAllinputValid() {
    return _isValidUsername(loginObject.username) &&
        _isValidPassword(loginObject.password);
  }

  @override
  Sink get inputAllInputIsValid => _allInputIsValidStreamControlller.sink;

  @override
  Stream<bool> get outputAllInputValid =>
      _allInputIsValidStreamControlller.stream.map((_) => _isAllinputValid());
}

abstract class LoginViewModelInput {
  // three functions for actions
  setUserName(String username);

  setPassword(String password);

  login();

  // two sinks for stream

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputAllInputIsValid;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputUserNameValid;

  Stream<bool> get outputPasswordValid;

  Stream<bool> get outputAllInputValid;
}
