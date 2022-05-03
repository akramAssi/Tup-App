import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/presentation/resources/assets_mangers.dart';
import 'package:test_app/presentation/resources/color_manager.dart';
import 'package:test_app/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }
@override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
          child: Image(
        image: const AssetImage(ImageAsset.splashLogo),
        width: MediaQuery.of(context).size.width * 0.7,
      )),
    );
  }

  void _goNext() {
    Navigator.of(context).pushReplacementNamed(Routes.onBoardingRoute);
  }
}
