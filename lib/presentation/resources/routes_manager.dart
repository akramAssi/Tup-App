import 'package:flutter/material.dart';
import 'package:test_app/app/di.dart';
import 'package:test_app/presentation/login/login.dart';
import 'package:test_app/presentation/main/main_view.dart';
import 'package:test_app/presentation/onboarding/onboarding.dart';
import 'package:test_app/presentation/register/register.dart';
import 'package:test_app/presentation/resources/string_manager.dart';
import 'package:test_app/presentation/splash/splash.dart';
import 'package:test_app/presentation/store_details/store_details.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      default:
        return unDefineRoute();
    }
  }

  static Route unDefineRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text(AppStrings.pageNotFound)),
            ));
  }
}
