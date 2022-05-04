import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:test_app/domain/model/model.dart';
import 'package:test_app/presentation/base/base_viewmodel.dart';
import 'package:test_app/presentation/resources/assets_mangers.dart';
import 'package:test_app/presentation/resources/string_manager.dart';

class OnboradingViewModel extends BaseViewModel
    with OnboardingViewModelInput, OnBoardingViewModelOutput {
  // stream conroller
  final StreamController<SliderViewObject> _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;
  late PageController pageController;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = getSliderData();
    pageController = PageController();
    _postDataToView();
  }

  @override
  int goNext() {
    if (_currentIndex < _list.length - 1) {
      ++_currentIndex;
    }

    _postDataToView();
    return _currentIndex;
  }

  @override
  int goPrevious() {
    if (_currentIndex > 0) {
      --_currentIndex;
    }
    _postDataToView();
    return _currentIndex;
  }

  @override
  void pageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((SliderViewObject event) => event);

  List<SliderObject> getSliderData() => [
        SliderObject(
            title: AppStrings.onBoardingTitle1,
            subtitle: AppStrings.onBoardingSubTitle1,
            imagePath: ImageAsset.onBoardingImage1),
        SliderObject(
            title: AppStrings.onBoardingTitle2,
            subtitle: AppStrings.onBoardingSubTitle1,
            imagePath: ImageAsset.onBoardingImage2),
        SliderObject(
            title: AppStrings.onBoardingTitle3,
            subtitle: AppStrings.onBoardingSubTitle1,
            imagePath: ImageAsset.onBoardingImage3),
        SliderObject(
            title: AppStrings.onBoardingTitle4,
            subtitle: AppStrings.onBoardingSubTitle1,
            imagePath: ImageAsset.onBoardingImage4),
      ];

  _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

// input mean that orders that our view model will be  recive  from our view
abstract class OnboardingViewModelInput {
  void goNext(); // go to next page when click right arrow or swap to left
  void
      goPrevious(); // go to previous page when click left button  or swap right
  void pageChanged(int index);

  Sink
      get inputSliderViewObject; // this way to add data to stream (stream input )
}

// output mean that data or result that well be sent from  our viewmodel to our view
abstract class OnBoardingViewModelOutput {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  var x = OnboradingViewModel();
  int numOfSlider;

  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlider, this.currentIndex);
}
