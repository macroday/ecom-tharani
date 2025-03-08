import 'package:ecom_app/core/utils/ecom_icon_template.dart';
import 'package:ecom_app/features/home/home_bloc/home_api_bloc/home_api_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeModuleWidgets {
  //
  //======================== App Bar Row ========================
  //
  Widget homeAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 10.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome Back 👋',
                  style: GoogleFonts.montserrat(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp)),
              Text('Samco',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 20.sp)),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: AppWidgets.appIconTemplate(
                    context,
                    0,
                    0,
                    0,
                    0,
                    40,
                    35,
                    20,
                    Colors.grey.withOpacity(0.2),
                    Colors.black,
                    Icons.shopping_cart_outlined,
                    50),
              ),
              AppWidgets.appIconTemplate(
                  context,
                  0,
                  0,
                  0,
                  0,
                  40,
                  35,
                  20,
                  Colors.grey.withOpacity(0.2),
                  Colors.black,
                  Icons.notifications_outlined,
                  50),
            ],
          )
        ],
      ),
    );
  }

  //
  //======================= Bottom Bar ========================
  //
  Widget homeBottomBar(
      int selectedIndex, Function(int) onBottomBarItemSelected) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onBottomBarItemSelected,
      selectedItemColor: const Color.fromARGB(255, 234, 163, 56),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border), label: 'Favorites'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  //
  //========================= Init Page Content ========================
  //

  Widget initPageWidget() {
    PageController bannerController = PageController();
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100.h,
            margin: EdgeInsets.only(left: 10.r, right: 10.r),
            child: PageView(
              controller: bannerController,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: SizedBox(
                    child: Image.asset('assets/images/spclDiscountOne.png',
                        fit: BoxFit.cover),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: SizedBox(
                    child: Image.asset('assets/images/spclDiscountTwo.png',
                        fit: BoxFit.fitWidth),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: SizedBox(
                    child: Image.asset('assets/images/spclDiscountThree.png',
                        fit: BoxFit.fitWidth),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            child: SmoothPageIndicator(
              controller: bannerController,
              count: 3,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.orange,
                dotHeight: 6,
                dotWidth: 6,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.r),
                  child: Text(
                    'Curated Weekly',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Text(
                    'See All',
                    style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(255, 234, 163, 56),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            child: homeProductList(),
          )
        ],
      ),
    );
  }

  Widget homeProductList() {
    return BlocBuilder<HomeApiBloc, HomeApiState>(
      builder: (context, state) {
        if (state is HomeApiInitial) {
          context
              .read<HomeApiBloc>()
              .add(FetchHomePageProducts(limit: 6, page: 1));
        } else if (state is HomeApiLoading) {
          Future.delayed(const Duration(milliseconds: 300));
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeApiError) {
          print('----------------ERROR-------------------');
        } else if (state is HomeApiLoaded) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                if (!state.hasReachedMax) {
                  context.read<HomeApiBloc>().add(FetchHomePageProducts(
                      limit: 2, page: state.currentPage + 1));
                }
              }
              return false;
            },
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              itemCount: state.products.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    border: Border.all(color: Colors.black.withOpacity(0.12)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: 130.w,
                        height: 120.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.w),
                          child: Image.network(
                            product.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error, color: Colors.red),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reebok',
                                style:
                                    GoogleFonts.montserrat(color: Colors.grey)),
                            Text(product.title,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.orange, size: 16.sp),
                                    Text(
                                      '4.8 (292)',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Text('\$${product.price}',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const Center(child: Text('No products available'));
      },
    );
  }

  //
  //======================= Search Bar Row ========================
  //
  Widget homeSearchBar(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 280.w,
            height: 60.h,
            margin: EdgeInsets.only(
              left: 10.w,
            ),
            child: SizedBox(
              height: double.infinity,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 22.sp,
                    color: Colors.grey,
                  ),
                  suffixIcon: _textFieldWidgets(),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22.w),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLength: 20,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                buildCounter: (context,
                        {required currentLength,
                        required isFocused,
                        required maxLength}) =>
                    null,
              ),
            ),
          ),
          AppWidgets.appIconTemplate(context, 0, 3.5, 15, 0, 45, 40, 25,
              Colors.grey.withOpacity(0.2), Colors.black, Icons.tune, 50)
        ]);
  }

  Widget _textFieldWidgets() {
    return SizedBox(
      width: 50.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 20.h,
            width: 1.5.w, // Divider width
            color: Colors.grey.shade400, // Divider color
          ),
          SizedBox(width: 10.w),
          Icon(Icons.mic_none_outlined, size: 22.sp, color: Colors.grey),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }
}
