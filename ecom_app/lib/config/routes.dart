import 'package:ecom_app/features/home/home_presentation/ecom_home_screen.dart';
import 'package:ecom_app/features/onBoarding/on_boarding_presentation/onBoarding_pages/on_boarding_screen.dart';
import 'package:flutter/material.dart';

//=============================== Handles Navigation ===================================

class AppRoutes {
  static const String onBoarding = '/';
  static const String home = '/home';
  static Route<dynamic> navigateToRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case onBoarding:
        return MaterialPageRoute(builder: (_) => const GetOnBoardingScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const EcomHomePage());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('Page Not Found')),
                ));
    }
  }
}
