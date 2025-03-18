import 'package:ecom_app/core/utils/ecom_common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Bounceable(
                    scaleFactor: 0.6,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: AppWidgets.appIconTemplate(
                        context,
                        0,
                        0,
                        0,
                        0,
                        35,
                        30,
                        20,
                        Colors.grey.withOpacity(0.2),
                        Colors.black,
                        Icons.arrow_back,
                        50.w),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 60.w),
                  child: Text(
                    'Notifications',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 25.sp,
                    color: const Color.fromARGB(255, 234, 163, 56),
                  ),
                )
              ],
            ),
            Expanded(
                child: AppWidgets.ecomEmptyScreen(
                    Icons.notifications_active_outlined,
                    'No Notifications Found')),
          ]),
        ),
      ),
    );
  }
}
