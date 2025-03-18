import 'package:ecom_app/core/utils/ecom_common_widgets.dart';
import 'package:ecom_app/features/cart/cart_bloc/ecom_cart_bloc.dart';
import 'package:ecom_app/features/cart/cart_pages/ecom_cart_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EcomCartPage extends StatelessWidget {
  const EcomCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Container(
              width: size.width,
              height: size.height,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(left: 16.r, right: 16.r, top: 16.r),
                child: state.cartItems.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CartWidgets().cartHeaderView(context),
                          Flexible(
                            child: CartWidgets().cartContentView(
                                context, state.cartItems, state),
                          ),
                          CartWidgets().totalPriceContainer(state.grandTotal),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: CartWidgets().checkOutButton(
                                context, size.width, state.cartItems),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          CartWidgets().cartHeaderView(context),
                          Expanded(
                              child: Center(
                            child: AppWidgets.ecomEmptyScreen(
                                Icons.shopping_cart_outlined,
                                'No Items in Cart'),
                          ))
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
