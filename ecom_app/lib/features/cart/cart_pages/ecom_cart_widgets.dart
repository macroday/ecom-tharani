import 'package:ecom_app/config/routes.dart';
import 'package:ecom_app/core/utils/ecom_common_widgets.dart';
import 'package:ecom_app/features/cart/cart_bloc/ecom_cart_bloc.dart';
import 'package:ecom_app/features/checkOut/check_out_model/check_out_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CartWidgets {
  Widget cartHeaderView(BuildContext context) {
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
          padding: EdgeInsets.only(left: 100.w),
          child: Text(
            'Cart',
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
    );
  }

  Widget cartContentView(
      BuildContext context, List<CartBundle> cartList, CartState state) {
    return Column(children: [
      Expanded(
        child: ListView.builder(
          itemCount: cartList.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return cartListItem(context, index, cartList);
          },
        ),
      ),
      state.hasSelectedItems
          ? Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(bottom: 30.r),
              child: deleteButton(context))
          : const SizedBox.shrink()
    ]);
  }

  Widget cartListItem(
      BuildContext context, int cartIndex, List<CartBundle> cartList) {
    final item = cartList[cartIndex];

    return Container(
      width: double.infinity,
      height: 80.h,
      margin: EdgeInsets.only(
          left: 5.r,
          right: 5.r,
          top: cartIndex == 0 ? 16.r : 0,
          bottom: cartIndex != cartList.length ? 8.r : 0),
      padding: EdgeInsets.only(top: 8.r, bottom: 8.r),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.0.w),
          borderRadius: BorderRadius.circular(12.w)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12.w),
          child: Image.network(
            item.imageUrl,
            width: 80.w,
            height: 80.h,
          ),
        ),
        title: Text(
          item.title,
          style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 8.0.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Bounceable(
                scaleFactor: 0.7,
                onTap: () => onPlusTapped(context, item.id.toString()),
                child: AppWidgets.appIconTemplate(
                    context,
                    0,
                    0,
                    0,
                    0,
                    30,
                    25,
                    20,
                    Colors.grey.withOpacity(0.2),
                    Colors.black,
                    Icons.add,
                    50),
              ),
              SizedBox(width: 10.w),
              Text(
                item.quantity.toString(),
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(width: 10.w),
              Bounceable(
                scaleFactor: 0.7,
                onTap: () => onMinusTapped(context, item.id.toString()),
                child: AppWidgets.appIconTemplate(
                    context,
                    0,
                    0,
                    0,
                    0,
                    30,
                    25,
                    20,
                    Colors.grey.withOpacity(0.2),
                    Colors.black,
                    Icons.remove,
                    50),
              ),
            ],
          ),
        ),
        trailing: Column(children: [
          GestureDetector(
            onTap: () {
              context.read<CartBloc>().add(ToggleSelection(item.id.toString()));
            },
            child: Icon(
              item.isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: Colors.black,
            ),
          ),
          Text(
            '\$ ${item.price.toString()}',
            style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ]),
      ),
    );
  }

  Widget totalPriceContainer(double grandTotal) {
    return Container(
      width: double.infinity,
      height: 100.h,
      margin: EdgeInsets.only(bottom: 40.r),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
          border: Border.all(width: 1.w, color: Colors.black)),
      child: Padding(
        padding:
            EdgeInsets.only(left: 16.r, right: 16.r, top: 10.r, bottom: 10.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text(
                  'Total Price',
                  style: GoogleFonts.montserrat(
                      color: Colors.grey,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  '\$ ${grandTotal - 5}', // Removing GST for clarity
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
            SizedBox(height: 5.h),
            Container(height: 1.h, width: double.infinity, color: Colors.grey),
            SizedBox(height: 5.h),
            Row(
              children: [
                Text(
                  'GST',
                  style: GoogleFonts.montserrat(
                      color: Colors.grey,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  '\$ 5',
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
            SizedBox(height: 5.h),
            Container(height: 1.h, width: double.infinity, color: Colors.grey),
            SizedBox(height: 5.h),
            Row(
              children: [
                Text(
                  'Grand Total',
                  style: GoogleFonts.montserrat(
                      color: Colors.grey,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  '\$ $grandTotal',
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget deleteButton(BuildContext context) {
    return Bounceable(
      scaleFactor: 0.6,
      onTap: () {
        context.read<CartBloc>().add(RemoveSelectedItems());
      },
      child: Container(
        width: 100.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 163, 56),
          borderRadius: BorderRadius.circular(25.w),
        ),
        child: Center(
          child: Text('Delete',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }

  Widget checkOutButton(
      BuildContext context, double width, List<CartBundle> bundle) {
    final List<CheckOutBundle> checkOutBundle = [];
    checkOutBundle.addAll(bundle.map((cartItem) => CheckOutBundle(
          title: cartItem.title,
          price: cartItem.price,
          image: cartItem.imageUrl,
          quantity: cartItem.quantity,
        )));
    return Bounceable(
      scaleFactor: 0.6,
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.checkOut,
            arguments: checkOutBundle);
      },
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 163, 56),
          borderRadius: BorderRadius.circular(25.w),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            margin: EdgeInsets.only(left: (width / 2) * 0.58.w),
            child: Text('Checkout',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                )),
          ),
          AppWidgets.appIconTemplate(
              context,
              0,
              0,
              0,
              0,
              45,
              40,
              30,
              Colors.transparent,
              Colors.white,
              Icons.arrow_circle_right_outlined,
              0.w)
        ]),
      ),
    );
  }

  Widget deleteCheckBox(BuildContext context) {
    return AppWidgets.appIconTemplate(
        context,
        0,
        0,
        0,
        0,
        30,
        25,
        15,
        Colors.transparent,
        Colors.black,
        Icons.check_box_outline_blank_rounded,
        0.w);
  }

  Widget cartEmptyView() {
    return Center(
      child: Text(
        'Cart is Empty',
        style: GoogleFonts.montserrat(
            color: Colors.grey, fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  void onPlusTapped(BuildContext context, String itemId) {
    context.read<CartBloc>().add(IncreaseQuantity(itemId));
  }

  void onMinusTapped(BuildContext context, String itemId) {
    context.read<CartBloc>().add(DecreaseQuantity(itemId));
  }
}
