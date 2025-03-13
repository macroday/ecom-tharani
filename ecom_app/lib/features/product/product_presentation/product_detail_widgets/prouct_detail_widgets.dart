import 'package:ecom_app/features/product/product_bloc/product_detail_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProuctDetailWidgets {
  Widget productImage(double width, String img) {
    return Column(
      children: [
        Container(
          width: width,
          height: 300.h,
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black.withOpacity(0.09), width: 10.w),
              borderRadius: BorderRadius.circular(12.w)),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.w),
                child: Image.network(
                  img,
                  width: width,
                  height: 300.h,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 25,
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(12.w),
                      border: Border.all(
                          color: Colors.transparent.withOpacity(0.1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return suggestionRowList(index, img);
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget suggestionRowList(int imageIndex, String img) {
    return BlocBuilder<ImageSuggestionBloc, ImageSuggestionState>(
        builder: (BuildContext context, ImageSuggestionState state) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0.w),
        child: Bounceable(
          scaleFactor: 0.8,
          onTap: () {
            context
                .read<ImageSuggestionBloc>()
                .add(ImageSuggestionEvent(selectdImageIndex: imageIndex));
          },
          child: Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
                border: Border.all(
                    color: state.selectdImageIndex == imageIndex
                        ? const Color.fromARGB(255, 234, 163, 56)
                        : Colors.grey,
                    width: 2.w),
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.white),
            child: Image.network(img),
          ),
        ),
      );
    });
  }

  Widget productDetailRow(String name, String price) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        name,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        maxLines: 2,
        softWrap: true,
      ),
      Text(
        '\$$price',
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.normal),
      ),
    ]);
  }

  Widget sizeSelectionRow() {
    List<String> sizeList = ['S', 'M', 'L', 'XL'];
    return BlocBuilder<SizeSelectionBloc, SizeSelectionState>(
        builder: (context, state) {
      return Row(
        children: [
          Row(
            children: sizeList.map((size) {
              return Padding(
                padding: EdgeInsets.only(right: 8.r),
                child: Bounceable(
                  scaleFactor: 0.6,
                  onTap: () {
                    context.read<SizeSelectionBloc>().add(
                        SizeSelectionEvent(sizeIndex: sizeList.indexOf(size)));
                  },
                  child: Container(
                    width: 40.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        color: state.sizeIndex == sizeList.indexOf(size)
                            ? const Color.fromARGB(255, 234, 163, 56)
                            : Colors.transparent,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.w)),
                    child: Center(
                      child: Text(
                        size,
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const Spacer(),
          BlocBuilder<ProductQuantityBloc, ProductQuantityState>(
              builder: (context, state) {
            return Container(
              width: 90.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(22.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22.w),
                        bottomLeft: Radius.circular(22.w)),
                    child: SizedBox(
                      width: 30.w,
                      height: 30.h,
                      child: Center(
                        child: Container(
                          width: 25.w,
                          height: 22.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(22.w),
                          ),
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.remove,
                                size: 10.sp,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                if (state.quantity != 1) {
                                  context.read<ProductQuantityBloc>().add(
                                      ProductQuantityEvent(
                                          quantity: state.quantity - 1));
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                    height: 30.h,
                    child: Center(
                      child: Text(
                        state.quantity <= 9
                            ? '0${state.quantity}'
                            : '${state.quantity}',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(22.w),
                        bottomRight: Radius.circular(22.w)),
                    child: SizedBox(
                      width: 30.w,
                      height: 30.h,
                      child: Center(
                        child: Container(
                          width: 25.w,
                          height: 22.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(22.w),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 10.sp,
                            ),
                            onPressed: () {
                              if (state.quantity != 10) {
                                context.read<ProductQuantityBloc>().add(
                                    ProductQuantityEvent(
                                        quantity: state.quantity + 1));
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      );
    });
  }

  Widget bottomButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 120.w,
          height: 35.h,
          child: OutlinedButton(
            onPressed: () {},
            child: Text(
              'Buy Now',
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp),
            ),
          ),
        ),
        SizedBox(width: 20.0.w),
        SizedBox(
          width: 180.w,
          height: 35.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 234, 163, 56)),
            onPressed: () {},
            child: Text(
              'Add to cart',
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget productDescription(String description) {
    return BlocBuilder<DescriptionCubit, bool>(
      builder: (context, isFirstHalfVisible) {
        final midPoint = (description.length / 2).round();
        final firstHalf = description.substring(0, midPoint);
        final secondHalf = description.substring(midPoint);

        return RichText(
          text: TextSpan(
            text: isFirstHalfVisible ? firstHalf : secondHalf,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 14.sp,
            ),
            children: [
              TextSpan(
                text: isFirstHalfVisible ? '... Show More' : ' Show Less',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () =>
                      context.read<DescriptionCubit>().toggleDescription(),
              ),
            ],
          ),
        );
      },
    );
  }
}
