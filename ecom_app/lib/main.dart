import 'package:ecom_app/config/routes.dart';
import 'package:ecom_app/core/utils/ecom_product_utils.dart';
import 'package:ecom_app/features/cart/cart_bloc/ecom_cart_bloc.dart';
import 'package:ecom_app/features/favorites/favorite_bloc/ecom_favorite_bloc.dart';
import 'package:ecom_app/features/search/search_bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => FavoriteBloc()),
        BlocProvider(create: (_) => SearchBloc(ProductUtils.ecomProductList))
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'US'),
              ],
              title: 'Mini E-Commerce',
              theme: ThemeData(
                primarySwatch: Colors.orange,
                fontFamily: 'montserrat',
              ),

              //================== App Routes =================
              initialRoute: AppRoutes.onBoarding,
              onGenerateRoute: AppRoutes.navigateToRoute,
            );
          }),
    );
  }
}
