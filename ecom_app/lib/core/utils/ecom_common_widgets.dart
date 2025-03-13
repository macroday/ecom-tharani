import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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

  static Widget productItemWidget(String imgSrc, String productName,
      double procuctRating, int ratingCount, double productPrice) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.w),
        border: Border.all(color: Colors.black.withOpacity(0.12)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.w),
            child: Container(
              width: 140.w,
              height: 120.h,
              padding: EdgeInsets.all(5.r),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.w),
                child: Image.network(
                  imgSrc,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 12.sp),
                        Text(
                          '$procuctRating ($ratingCount)',
                          style: GoogleFonts.montserrat(
                              color: Colors.black, fontSize: 12.sp),
                        ),
                      ],
                    ),
                    Text('\$$productPrice',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, fontSize: 12.sp)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
