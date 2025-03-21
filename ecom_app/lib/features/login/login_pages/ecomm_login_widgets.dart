import 'package:ecom_app/config/routes.dart';
import 'package:ecom_app/features/login/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidgets {
  static Widget loginIcon() {
    return SizedBox(
      width: 50.w,
      height: 50.h,
      child: Icon(
        Icons.login,
        size: 30.sp,
        color: Colors.orange,
      ),
    );
  }

  static Widget loginHeader(String headerTxt) {
    return Text(
      headerTxt,
      style: GoogleFonts.montserrat(
        fontSize: 20.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Widget loginSubHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don\'t have an account?',
            style: GoogleFonts.montserrat(
                fontSize: 12.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600)),
        SizedBox(
          width: 5.w,
        ),
        Text(
          'Sign Up',
          style: GoogleFonts.montserrat(
              fontSize: 12.sp,
              color: Colors.orange,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  static Widget loginButton(BuildContext context) {
    return BlocBuilder<LoginBloc, ButtonState>(builder: (context, state) {
      return Bounceable(
        scaleFactor: 0.6,
        onTap: () {
          context.read<LoginBloc>().add(ButtonClick());
          debugPrint(state.email);
          if (state.email.isNotEmpty) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else {
            AlertDialog(
              title: const Text('Error'),
              content: const Text('Response Failed'),
              actions: [
                Bounceable(
                  scaleFactor: 0.6,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 25.h,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    child: Center(
                        child: Text(
                      'OK',
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                  ),
                )
              ],
            );
          }
        },
        child: Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(22.w),
            ),
            child: Center(
              child: Text(
                'Log In',
                style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )),
      );
    });
  }

  static Widget loginInputField(
      IconData textFieldIcon, String hintText, TextInputType textInputType) {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.w),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          prefixIcon: Icon(
            textFieldIcon,
            size: 12.sp,
          ),
          suffixIcon: hintText.contains('Password')
              ? Icon(
                  Icons.visibility_off,
                  size: 12.sp,
                )
              : null,
          labelText: hintText,
          labelStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.w),
          ),
        ),
        keyboardType: textInputType,
        obscureText: hintText.contains('Password') ? true : false,
      ),
    );
  }

  static Widget forgotPasswordText() {
    return Text('Forgot Password?',
        style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline));
  }
}
