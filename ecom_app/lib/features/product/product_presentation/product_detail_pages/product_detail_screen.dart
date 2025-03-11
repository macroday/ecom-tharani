import 'package:ecom_app/core/utils/ecom_constants.dart';
import 'package:ecom_app/features/product/product_bloc/product_detail_bloc.dart';
import 'package:ecom_app/features/product/product_presentation/product_detail_widgets/prouct_detail_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final EcomBundle ecomBundle;
  const ProductDetailPage({super.key, required this.ecomBundle});

  @override
  State<ProductDetailPage> createState() {
    return ProductDetailState();
  }
}

class ProductDetailState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => ImageSuggestionBloc()),
        BlocProvider(create: (_) => SizeSelectionBloc()),
        BlocProvider(create: (_) => ProductQuantityBloc()),
        BlocProvider(create: (_) => DescriptionCubit()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Bounceable(
                          scaleFactor: 0.7,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 35.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.r),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Detail Product',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold, fontSize: 15.sp),
                        ),
                        Container(
                          width: 35.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.r),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ProuctDetailWidgets()
                    .productImage(size.width, widget.ecomBundle.imageUrl),
                SizedBox(height: 4.h),
                ProuctDetailWidgets().productDetailRow(widget.ecomBundle.title,
                    widget.ecomBundle.price.toString()),
                Text(
                  'Select Size',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                ProuctDetailWidgets().sizeSelectionRow(),
                SizedBox(height: 8.h),
                Text(
                  'Description',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.h),
                ProuctDetailWidgets().productDescription(
                  widget.ecomBundle.description,
                ),
                Spacer(),
                ProuctDetailWidgets().bottomButtonRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
