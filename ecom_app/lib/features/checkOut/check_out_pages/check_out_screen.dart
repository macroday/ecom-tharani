import 'package:ecom_app/core/utils/ecom_common_widgets.dart';
import 'package:ecom_app/features/checkOut/check_out_bloc/check_out_bloc.dart';
import 'package:ecom_app/features/checkOut/check_out_model/check_out_model.dart';
import 'package:ecom_app/features/checkOut/check_out_pages/check_out_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCheckOut extends StatelessWidget {
  final List<CheckOutBundle> bundle;
  const ProductCheckOut({super.key, required this.bundle});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
                left: 16.r, right: 16.r, top: 16.r, bottom: 20.r),
            child: bundle.isNotEmpty
                ? Column(children: [
                    CheckOutWidgets().checkOutHeaderView(context),
                    SizedBox(height: 20.h),
                    CheckOutWidgets().checkOutPaymentMethod(context),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: ListView.builder(
                        itemCount: bundle.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CheckOutWidgets()
                              .cartItem(context, index, bundle);
                        },
                      ),
                    ),
                    const Spacer(),
                    CheckOutWidgets().checkOutButtonRow(context),
                  ])
                : Column(children: [
                    CheckOutWidgets().checkOutHeaderView(context),
                    Expanded(
                        child: AppWidgets.ecomEmptyScreen(
                            Icons.shopping_cart_checkout_outlined,
                            'No Items to Checkout'))
                  ]),
          ),
        )),
      ),
    );
  }
}
