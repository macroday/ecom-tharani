import 'package:ecom_app/core/utils/ecom_constants.dart';
import 'package:ecom_app/features/cart/cart_presentation/cart_pages/ecom_cart_screen.dart';
import 'package:ecom_app/features/favorites/favorite_presentation/favorite_pages/ecom_favorite_screen.dart';
import 'package:ecom_app/features/home/home_presentation/home_pages/ecom_home_screen.dart';
import 'package:ecom_app/features/onBoarding/on_boarding_presentation/onBoarding_pages/on_boarding_screen.dart';
import 'package:ecom_app/features/product/product_presentation/product_detail_pages/product_detail_screen.dart';
import 'package:flutter/material.dart';

//=============================== Handles Navigation ===================================

class AppRoutes {
  static const String onBoarding = '/';
  static const String home = EcomConstants.ecomHomePath;
  static const String productDetail = EcomConstants.ecomProductPath;
  static const String cart = EcomConstants.ecomCartPath;
  static const String favorites = EcomConstants.ecomFavoritePath;
  static Route<dynamic> navigateToRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case onBoarding:
        return MaterialPageRoute(builder: (_) => const GetOnBoardingScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const EcomHomePage());
      case productDetail:
        final bundle = routeSettings.arguments as EcomBundle;
        return MaterialPageRoute(
            builder: (_) => ProductDetailPage(
                  ecomBundle: bundle,
                ));
      case cart:
        return MaterialPageRoute(builder: (_) => const EcomCartPage());
      case favorites:
        return MaterialPageRoute(builder: (_) => const EcomFavoritesPage());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('Page Not Found')),
                ));
    }
  }
}
