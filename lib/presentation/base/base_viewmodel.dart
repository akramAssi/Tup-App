abstract class BaseViewModel extends BaseViewModelInput
    with BaseViewModelOutput {
  // Sheard variables and methods between viewmodels that well be use through any  viewmodel
}

abstract class BaseViewModelInput {
  void start(); // will becaled in init of viewmodel
  void dispose(); // will be caled in dispose of viewmodel (class resources)
}

abstract class BaseViewModelOutput {}
