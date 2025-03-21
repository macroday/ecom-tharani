import 'package:ecom_app/core/utils/ecom_constants.dart';
import 'package:ecom_app/features/cart/cart_bloc/ecom_cart_bloc.dart';
import 'package:ecom_app/features/cart/cart_pages/ecom_cart_screen.dart';
import 'package:ecom_app/features/checkOut/check_out_bloc/check_out_model.dart';
import 'package:ecom_app/features/checkOut/check_out_pages/check_out_screen.dart';
import 'package:ecom_app/features/home/home_pages/ecom_home_screen.dart';
import 'package:ecom_app/features/login/login_pages/ecomm_login_screen.dart';
import 'package:ecom_app/features/notification/notification_screen.dart';
import 'package:ecom_app/features/onBoarding/onBoarding_pages/on_boarding_screen.dart';
import 'package:ecom_app/features/product/product_detail_pages/product_detail_screen.dart';
import 'package:flutter/material.dart';

//=============================== Handles Navigation ===================================

class AppRoutes {
  static const String onBoarding = '/';
  static const String home = EcomConstants.ecomHomePath;
  static const String productDetail = EcomConstants.ecomProductPath;
  static const String cart = EcomConstants.ecomCartPath;
  static const String checkOut = EcomConstants.checkOutPath;
  static const String notifications = EcomConstants.notificationPath;
  static const String login = EcomConstants.loginPath;
  static Route<dynamic> navigateToRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case onBoarding:
        return MaterialPageRoute(builder: (_) => const GetOnBoardingScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const EcomHomePage());
      case productDetail:
        final bundle = routeSettings.arguments as CartBundle;
        return MaterialPageRoute(
            builder: (_) => ProductDetailPage(
                  ecomBundle: bundle,
                ));
      case cart:
        return MaterialPageRoute(builder: (_) => EcomCartPage());
      case checkOut:
        final bundle = routeSettings.arguments as List<CheckOutBundle>;
        return MaterialPageRoute(
            builder: (_) => ProductCheckOut(
                  bundle: bundle,
                ));
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('Page Not Found')),
                ));
    }
  }
}
