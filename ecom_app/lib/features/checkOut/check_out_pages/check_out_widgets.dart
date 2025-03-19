import 'package:ecom_app/core/utils/ecom_common_widgets.dart';
import 'package:ecom_app/features/checkOut/check_out_bloc/check_out_bloc.dart';
import 'package:ecom_app/features/checkOut/check_out_bloc/check_out_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOutWidgets {
  Widget checkOutHeaderView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Bounceable(
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
        Padding(
          padding: EdgeInsets.only(left: 80.w),
          child: Text(
            'Checkout',
            style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Icon(
            Icons.check_circle_rounded,
            size: 25.sp,
            color: const Color.fromARGB(255, 234, 163, 56),
          ),
        )
      ],
    );
  }

  Widget checkOutPaymentMethod(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
          border: Border.all(color: Colors.black, width: 1.0.w)),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          paymentGatewayItem(context, 'GPay', Icons.mobile_friendly_rounded),
          SizedBox(
            height: 5.h,
          ),
          Container(
            width: double.infinity,
            height: 1.h,
            color: Colors.black,
          ),
          SizedBox(
            height: 5.h,
          ),
          paymentGatewayItem(context, 'Debit Card', Icons.credit_card_outlined),
          SizedBox(
            height: 5.h,
          ),
          Container(
            width: double.infinity,
            height: 1.h,
            color: Colors.black,
          ),
          SizedBox(
            height: 5.h,
          ),
          paymentGatewayItem(
              context, 'UPI ID', Icons.account_balance_wallet_outlined),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }

  Widget paymentGatewayItem(
      BuildContext context, String paymentGateway, IconData paymentIcon) {
    return BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, chkOutState) {
      return GestureDetector(
        onTap: () {
          context.read<PaymentBloc>().add(ChoosePaymentMode(
              paymentOption: paymentGateway == 'GPay'
                  ? 0
                  : paymentGateway == 'Debit Card'
                      ? 1
                      : paymentGateway == 'UPI ID'
                          ? 2
                          : 0));
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          AppWidgets.appIconTemplate(context, 0, 0, 0, 0, 35, 30, 20,
              Colors.transparent, Colors.orange, paymentIcon, 50.w),
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Text(
              paymentGateway,
              style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const Spacer(),
          AppWidgets.appIconTemplate(
              context,
              0,
              0,
              0,
              0,
              35,
              30,
              20,
              Colors.transparent,
              Colors.orange,
              chkOutState.paymentMode == paymentGateway
                  ? Icons.radio_button_on_outlined
                  : Icons.radio_button_off_outlined,
              50.w),
        ]),
      );
    });
  }

  Widget cartItem(
      BuildContext context, int index, List<CheckOutBundle> checkOutList) {
    return Container(
      width: double.infinity,
      height: 80.h,
      margin: EdgeInsets.only(
          left: 5.r,
          right: 5.r,
          top: index == 0 ? 16.r : 0,
          bottom: index != checkOutList.length ? 8.r : 0),
      padding: EdgeInsets.only(top: 8.r, bottom: 8.r),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.0.w),
          borderRadius: BorderRadius.circular(12.w)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12.w),
          child: Image.network(
            checkOutList[index].image,
            width: 80.w,
            height: 80.h,
          ),
        ),
        title: Text(
          checkOutList[index].title,
          style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 8.0.r),
          child: Text(
            checkOutList[index].quantity.toString(),
            style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
        trailing: Text(
          '\$ ${checkOutList[index].price.toString()}',
          style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  Widget checkOutButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Bounceable(
          scaleFactor: 0.6,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 150.w,
            height: 45.h,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(32.w),
            ),
            child: Center(
              child: Text(
                'Cancel',
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        Bounceable(
          scaleFactor: 0.6,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Item bought successfully!!!",
                style: GoogleFonts.montserrat(
                    color: Colors.white, fontSize: 16.sp),
              ),
              backgroundColor: Colors.orange,
            ));
            Navigator.of(context).pop();
          },
          child: Container(
            width: 150.w,
            height: 45.h,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 234, 163, 56),
              borderRadius: BorderRadius.circular(32.w),
            ),
            child: Center(
              child: Text(
                'Buy Now',
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
