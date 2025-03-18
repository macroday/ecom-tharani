import 'package:ecom_app/features/cart/cart_bloc/ecom_cart_bloc.dart';
import 'package:ecom_app/features/product/product_bloc/product_detail_bloc.dart';
import 'package:ecom_app/features/product/product_detail_pages/prouct_detail_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  final CartBundle ecomBundle;
  const ProductDetailPage({super.key, required this.ecomBundle});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => ImageSuggestionBloc()),
        BlocProvider(create: (_) => SizeSelectionBloc()),
        BlocProvider(create: (_) => ProductQuantityBloc()),
        BlocProvider(create: (_) => DescriptionCubit()),
        BlocProvider(create: (_) => CartValueCubit()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductDetailWidgets.buildHeader(context),
                SizedBox(height: 20.h),
                ProductDetailWidgets.productImage(
                    size.width, ecomBundle.imageUrl),
                SizedBox(height: 4.h),
                ProductDetailWidgets.productDetailRow(
                    ecomBundle.title, ecomBundle.price.toString()),
                Text('Select Size',
                    style: GoogleFonts.montserrat(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 8.h),
                BlocBuilder<ProductQuantityBloc, ProductQuantityState>(
                  builder: (context, state) {
                    return ProductDetailWidgets.sizeSelectionRow(state);
                  },
                ),
                SizedBox(height: 8.h),
                Text('Description',
                    style: GoogleFonts.montserrat(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 5.h),
                ProductDetailWidgets.productDescription(ecomBundle.description),
                SizedBox(height: 20.h),
                BlocBuilder<ProductQuantityBloc, ProductQuantityState>(
                  builder: (context, state) {
                    return ProductDetailWidgets.bottomButtonRow(
                        context, ecomBundle, state);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
