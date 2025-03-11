import 'package:ecom_app/config/routes.dart';
import 'package:ecom_app/core/utils/ecom_constants.dart';
import 'package:ecom_app/core/utils/ecom_icon_template.dart';
import 'package:ecom_app/features/home/home_bloc/home_api_bloc/home_api_state_manager.dart';
import 'package:ecom_app/features/home/home_bloc/home_ui_bloc/module_home_bloc.dart';
import 'package:ecom_app/features/product/product_bloc/product_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
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
    return BlocBuilder<HomeApiBloc, HomeApiState>(
      builder: (context, state) {
        if (state is HomeApiInitial) {
          context
              .read<HomeApiBloc>()
              .add(FetchHomePageProducts(limit: 6, page: 1));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollNotification) {
            if (scrollNotification is ScrollEndNotification &&
                scrollNotification.metrics.pixels >=
                    scrollNotification.metrics.maxScrollExtent &&
                state is HomeApiLoaded &&
                !state.hasReachedMax) {
              context.read<HomeApiBloc>().add(
                    FetchHomePageProducts(
                      limit: 4,
                      page: state.currentPage + 1,
                    ),
                  );
            }
            return false;
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100.h,
                      margin: EdgeInsets.symmetric(horizontal: 10.r),
                      child: PageView(
                        controller: bannerController,
                        children: [
                          _buildBanner('assets/images/spclDiscountOne.png'),
                          _buildBanner('assets/images/spclDiscountTwo.png'),
                          _buildBanner('assets/images/spclDiscountThree.png'),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SmoothPageIndicator(
                      controller: bannerController,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.orange,
                        dotHeight: 6,
                        dotWidth: 6,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    _buildSectionHeader(),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
              homeProductList(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBanner(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
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
        ),
      ],
    );
  }

  Widget homeProductList(HomeApiState state) {
    if (state is HomeApiLoading) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (state is HomeApiError) {
      return const SliverToBoxAdapter(
        child: Center(child: Text('Error loading products')),
      );
    } else if (state is HomeApiLoaded) {
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final product = state.products[index];
              return Bounceable(
                scaleFactor: 0.7,
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 300), () {
                    Navigator.pushNamed(context, AppRoutes.productDetail,
                        arguments: EcomBundle(
                            imageUrl: product.image,
                            title: product.title,
                            description: product.description,
                            price: product.price));
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    border: Border.all(color: Colors.black.withOpacity(0.12)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.w),
                        child: Container(
                          width: 140.w,
                          height: 120.h,
                          padding: EdgeInsets.all(5.r),
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
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reebok',
                                style:
                                    GoogleFonts.montserrat(color: Colors.grey)),
                            Text(
                              product.title,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.orange, size: 12.sp),
                                    Text(
                                      '${product.rating.rate} (${product.rating.count})',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black, fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                                Text('\$${product.price}',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: state.products.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      );
    }
    return const SliverToBoxAdapter(
      child: Center(child: Text('No products available')),
    );
  }

  //
  //======================= Search Bar Row ========================
  //
  Widget homeSearchBar(BuildContext context, FocusNode searchFocus,
      VoidCallback onTextFieldTap) {
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
                focusNode: searchFocus,
                onTap: () {
                  onTextFieldTap();
                },
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
          Bounceable(
            scaleFactor: 0.6,
            onTap: () {
              showFilterBottomSheet(context);
            },
            child: AppWidgets.appIconTemplate(context, 0, 3.5, 15, 0, 45, 40,
                25, Colors.grey.withOpacity(0.2), Colors.black, Icons.tune, 50),
          )
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
            width: 1.5.w,
            color: Colors.grey.shade400,
          ),
          SizedBox(width: 10.w),
          Icon(Icons.mic_none_outlined, size: 22.sp, color: Colors.grey),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }

  //
  //========================== Filter Screen ===========================
  //
  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0.w)),
      ),
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<SizeSelectionBloc>(
                create: (context) => SizeSelectionBloc()),
            BlocProvider<SliderValueCubit>(
                create: (context) => SliderValueCubit())
          ],
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: EdgeInsets.only(
                  left: 16.r, right: 16.r, bottom: 20.r, top: 5.r),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 5.h,
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12.w),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Product Name',
                      style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    _buildTextField('Product Name', 'eg. Shirt'),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Product Code',
                      style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    _buildTextField('Product Code', 'eg. SKU243'),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Brand',
                      style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    _buildTextField('Brand', 'eg. H&M'),
                    SizedBox(height: 10.h),
                    Text('Price Range',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    BlocBuilder<SliderValueCubit, double>(
                        builder: (context, value) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Slider(
                            value: value,
                            min: 0,
                            max: 500,
                            activeColor:
                                const Color.fromARGB(255, 234, 163, 56),
                            inactiveColor: Colors.grey.shade300,
                            onChanged: (value) {
                              context
                                  .read<SliderValueCubit>()
                                  .updateSliderValue(value);
                            },
                          )),
                          Text('\$${value.toStringAsFixed(2)}'),
                        ],
                      );
                    }),
                    SizedBox(height: 10.h),
                    Text('Select Size',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    BlocBuilder<SizeSelectionBloc, SizeSelectionState>(
                        builder: (context, state) {
                      return _buildSizeSelection(context, state);
                    }),
                    SizedBox(height: 10.h),
                    Text('Color',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    _buildColorSelection(),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildTextField(String label, String hint) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

Widget _buildSizeSelection(BuildContext context, SizeSelectionState state) {
  const sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  return Row(
    children: sizes.map((size) {
      return Padding(
        padding: EdgeInsets.only(right: 8.r),
        child: Bounceable(
          scaleFactor: 0.6,
          onTap: () {
            context
                .read<SizeSelectionBloc>()
                .add(SizeSelectionEvent(sizeIndex: sizes.indexOf(size)));
          },
          child: Container(
            width: 40.w,
            height: 30.h,
            decoration: BoxDecoration(
                color: state.sizeIndex == sizes.indexOf(size)
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
  );
}

Widget _buildColorSelection() {
  const colors = [Colors.blue, Colors.green, Colors.grey, Colors.brown];
  return Wrap(
    spacing: 8,
    children: colors.map((color) {
      return CircleAvatar(
        backgroundColor: color,
        radius: 12,
      );
    }).toList(),
  );
}
