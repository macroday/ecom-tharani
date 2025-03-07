import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWidgets {
  static Widget appIconTemplate(
      BuildContext context,
      double bottom,
      double top,
      double left,
      double right,
      double containerWidth,
      double containerHeight,
      double iconSize,
      Color containerColor,
      Color iconColor,
      IconData iconName,
      double borderRadius) {
    return Container(
      width: containerWidth.w,
      height: containerHeight.h,
      margin: EdgeInsets.only(
          left: left.w, top: top.h, bottom: bottom.h, right: right.w),
      decoration: ShapeDecoration(
          color: containerColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius.w)))),
      child: Icon(
        iconName,
        size: iconSize.sp,
        color: iconColor,
      ),
    );
  }
}
