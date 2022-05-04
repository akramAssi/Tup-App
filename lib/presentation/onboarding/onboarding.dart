import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/domain/model/model.dart';
import 'package:test_app/presentation/resources/assets_mangers.dart';
import 'package:test_app/presentation/resources/color_manager.dart';
import 'package:test_app/presentation/resources/routes_manager.dart';
import 'package:test_app/presentation/resources/string_manager.dart';
import 'package:test_app/presentation/resources/values_manager.dart';

import 'onborarding_viewmodel.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController _pageController;
  final OnboradingViewModel _viewModel = OnboradingViewModel();
  late Stream<SliderViewObject>  stream;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _viewModel.start();
     stream = _viewModel.outputSliderViewObject;

  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _viewModel.outputSliderViewObject,
      builder:
          (BuildContext context, AsyncSnapshot<SliderViewObject> snapshot) {
        return _getContentWidegt(context, snapshot.data);
      },
    );
  }

  Widget _getContentWidegt(BuildContext context, SliderViewObject? data) {
    if(data==null) {
      return SizedBox();
    }
    return Scaffold(
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: ColorManager.white,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: data.numOfSlider,
        onPageChanged: (index) {
          _viewModel.pageChanged(index);
        },
        itemBuilder: (BuildContext context, int index) {
          return PageBody(slideObject: data.sliderObject);
        },
      ),
      bottomSheet: getBottomSheet(data),
    );
  }

  SizedBox getBottomSheet(SliderViewObject data) {
    return SizedBox(
      height: AppSize.s100,
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
              },
              child: const Text(AppStrings.skipOnBoarding),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 30),
            color: ColorManager.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {

                    gotoPage(_viewModel.goPrevious());
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: ColorManager.white,
                  ),
                ),
                Row(
                  children: [
                    for (int i = 0; i < data.numOfSlider; i++)
                      Padding(
                        padding: const EdgeInsets.all(AppSize.s1_5),
                        child: Icon(
                          data.currentIndex == i
                              ? Icons.circle_outlined
                              : Icons.circle,
                          color: ColorManager.white,
                          size: AppSize.s14,
                        ),
                      )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    gotoPage(_viewModel.goNext());

                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void gotoPage(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: AppDuration.d300),
        curve: Curves.bounceInOut);
  }
}

class PageBody extends StatelessWidget {
  const PageBody({
    Key? key,
    required this.slideObject,
  }) : super(key: key);

  final SliderObject slideObject;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40),
        Text(
          slideObject.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: AppSize.s12),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Text(
            slideObject.subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(height: AppSize.s65),
        Image(image: AssetImage(slideObject.imagePath))
      ],
    );
  }
}

/////
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:test_app/domain/model.dart';
// import 'package:test_app/presentation/resources/assets_mangers.dart';
// import 'package:test_app/presentation/resources/color_manager.dart';
// import 'package:test_app/presentation/resources/routes_manager.dart';
// import 'package:test_app/presentation/resources/string_manager.dart';
// import 'package:test_app/presentation/resources/values_manager.dart';
//
// import 'onborarding_viewmodel.dart';
//
// class OnboardingView extends StatefulWidget {
//   const OnboardingView({Key? key}) : super(key: key);
//
//   @override
//   State<OnboardingView> createState() => _OnboardingViewState();
// }
//
// class _OnboardingViewState extends State<OnboardingView> {
//   late PageController _pageController;
//   OnboradingViewModel _viewModel = OnboradingViewModel();
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);
//     _viewModel.start();
//   }
//
//   @override
//   void dispose() {
//     _viewModel.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: _viewModel.outputSliderViewObject,
//       builder:
//           (BuildContext context, AsyncSnapshot<SliderViewObject> snapshot) {
//         return _getContentWidegt(context, snapshot.data);
//       },
//     );
//   }
//
//   Widget _getContentWidegt(BuildContext context, SliderViewObject? data) {
//     if (data == null) {
//       return Container();
//     }
//     return Scaffold(
//       appBar: AppBar(
//         elevation: AppSize.s0,
//         backgroundColor: ColorManager.white,
//         systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
//           statusBarColor: ColorManager.white,
//         ),
//       ),
//       body: PageView.builder(
//         controller: _pageController,
//         itemCount: data.numOfSlider,
//         onPageChanged: (index) {
//           _viewModel.pageChanged(index);
//         },
//         itemBuilder: (BuildContext context, int index) {
//           return PageBody(slideObject: data.sliderObject);
//         },
//       ),
//       bottomSheet: getBottomSheet(data),
//     );
//   }
//
//   SizedBox getBottomSheet(SliderViewObject? data) {
//     if (data == null) return const SizedBox();
//     return SizedBox(
//       height: AppSize.s100,
//       child: Column(
//         children: [
//           Align(
//             alignment: Alignment.bottomRight,
//             child: TextButton(
//               onPressed: () {
//                 Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
//               },
//               child: const Text(AppStrings.skipOnBoarding),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 30),
//             color: ColorManager.primary,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     setState(
//                           () {
//                         gotoPage(_viewModel.goPrevious());
//                       },
//                     );
//                   },
//                   icon: Icon(
//                     Icons.arrow_back_ios,
//                     color: ColorManager.white,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     for (int i = 0; i < data.numOfSlider; i++)
//                       Padding(
//                         padding: const EdgeInsets.all(AppSize.s1_5),
//                         child: Icon(
//                           data.currentIndex == i
//                               ? Icons.circle_outlined
//                               : Icons.circle,
//                           color: ColorManager.white,
//                           size: AppSize.s14,
//                         ),
//                       )
//                   ],
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       gotoPage(_viewModel.goNext());
//                     });
//                   },
//                   icon: Icon(
//                     Icons.arrow_forward_ios,
//                     color: ColorManager.white,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   void gotoPage(int index) {
//     _pageController.animateToPage(index,
//         duration: const Duration(milliseconds: AppDuration.d300),
//         curve: Curves.bounceInOut);
//   }
// }
//
// class PageBody extends StatelessWidget {
//   const PageBody({
//     Key? key,
//     required this.slideObject,
//   }) : super(key: key);
//
//   final SliderObject slideObject;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         const SizedBox(height: AppSize.s40),
//         Text(
//           slideObject.title,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.headline1,
//         ),
//         const SizedBox(height: AppSize.s12),
//         Padding(
//           padding: const EdgeInsets.all(AppPadding.p20),
//           child: Text(
//             slideObject.subtitle,
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.subtitle1,
//           ),
//         ),
//         const SizedBox(height: AppSize.s65),
//         Image(image: AssetImage(slideObject.imagePath))
//       ],
//     );
//   }
// }
