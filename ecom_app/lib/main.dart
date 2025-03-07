import 'package:ecom_app/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690), // Adjust this to match your design
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
              Locale('en', 'US'), // Add other supported locales if needed
            ],
            title: 'Mini E-Commerce',
            theme: ThemeData(
              primarySwatch: Colors.orange,
              fontFamily:
                  'montserrat', // Ensure you added Google Fonts in pubspec.yaml
            ),

            //================== App Routes =================
            initialRoute: AppRoutes.onBoarding,
            onGenerateRoute: AppRoutes.navigateToRoute,
          );
        });
  }
}
