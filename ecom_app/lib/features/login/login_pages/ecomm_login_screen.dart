import 'package:ecom_app/features/login/login_bloc/login_bloc.dart';
import 'package:ecom_app/features/login/login_pages/ecomm_login_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: size.width,
            height: size.height,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginWidgets.loginIcon(),
                SizedBox(height: 15.h),
                LoginWidgets.loginHeader('Sign in to your'),
                SizedBox(height: 5.h),
                LoginWidgets.loginHeader('Account'),
                SizedBox(height: 10.h),
                LoginWidgets.loginSubHeader(),
                SizedBox(height: 15.h),
                LoginWidgets.loginInputField(Icons.email_outlined,
                    'Enter your email', TextInputType.emailAddress),
                SizedBox(height: 5.h),
                LoginWidgets.loginInputField(Icons.lock_outlined,
                    'Enter Password', TextInputType.visiblePassword),
                SizedBox(height: 8.h),
                LoginWidgets.forgotPasswordText(),
                SizedBox(height: 15.h),
                LoginWidgets.loginButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
