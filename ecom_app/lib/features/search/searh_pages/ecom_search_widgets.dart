import 'package:ecom_app/config/routes.dart';
import 'package:ecom_app/core/utils/ecom_common_widgets.dart';
import 'package:ecom_app/core/utils/ecom_constants.dart';
import 'package:ecom_app/features/cart/cart_bloc/ecom_cart_bloc.dart';
import 'package:ecom_app/features/home/home_data/home_model.dart';
import 'package:ecom_app/features/search/search_bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchWidgets {
  static Widget buildCategoryList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: EcomConstants.searchCategories.length,
      itemBuilder: (context, index) {
        return Bounceable(
            scaleFactor: 0.7,
            onTap: () async {
              await Future.delayed(const Duration(milliseconds: 200));
              if (!context.mounted) return;
              context.read<SearchBloc>().add(SearchTextChanged(
                  text: EcomConstants.searchCategories[index]));
            },
            child: categoryListItem(index));
      },
    );
  }

  static Widget categoryListItem(int categoryIndex) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: 20.w,
              height: 20.h,
              margin: EdgeInsets.only(left: 20.w),
              child: Icon(
                Icons.search,
                color: Colors.grey,
                size: 20.sp,
              )),
          SizedBox(width: 10.w),
          SizedBox(
            child: Text(
              EcomConstants.searchCategories[categoryIndex],
              style:
                  GoogleFonts.montserrat(fontSize: 15.sp, color: Colors.black),
            ),
          ),
          const Spacer(),
          Container(
              width: 20.w,
              height: 20.h,
              margin: EdgeInsets.only(right: 22.w),
              child: Icon(
                Icons.north_east,
                color: Colors.grey,
                size: 18.sp,
              ))
        ],
      ),
      SizedBox(
          height: categoryIndex != EcomConstants.searchCategories.length
              ? 15.h
              : 0),
      (categoryIndex == EcomConstants.searchCategories.length - 1)
          ? Container(
              width: double.infinity,
              height: 0.5.h,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              color: Colors.grey,
            )
          : const SizedBox.shrink()
    ]);
  }

  static Widget searchPageContent(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitialState) {
          return const Center(child: Text('Search for products...'));
        } else if (state is SearchLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchLoadedState) {
          return searchItemContainer(state);
        } else if (state is SearchErrorState) {
          return Center(
              child: AppWidgets.ecomEmptyScreen(
                  Icons.search_outlined, state.error));
        }
        return const Center(child: Text('Start searching...'));
      },
    );
  }

  static Widget searchItemContainer(SearchLoadedState state) {
    return ListView.builder(
      itemCount: state.searchResult.length,
      itemBuilder: (context, index) {
        final product = state.searchResult[index];
        return Bounceable(
          scaleFactor: 0.6,
          onTap: () async {
            await Future.delayed(const Duration(milliseconds: 300));
            if (!context.mounted) return;
            onSearchItemTap(context, product);
          },
          child: Container(
            margin: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 5.h),
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 234, 163, 56),
                    width: 1.0.w),
                borderRadius: BorderRadius.circular(12.w)),
            child: ListTile(
              leading: Image.network(product.image, width: 50.w),
              title: Text(product.title,
                  style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
              subtitle: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }

  static void onSearchItemTap(BuildContext context, HomeModel tappedProduct) {
    CartBundle bundle = CartBundle(
        id: tappedProduct.id,
        title: tappedProduct.title,
        imageUrl: tappedProduct.image,
        price: tappedProduct.price,
        description: tappedProduct.description);
    Navigator.pushNamed(context, AppRoutes.productDetail, arguments: bundle);
  }
}
