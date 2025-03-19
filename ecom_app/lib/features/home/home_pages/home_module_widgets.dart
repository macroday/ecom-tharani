import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom_app/config/routes.dart';
import 'package:ecom_app/core/utils/ecom_common_widgets.dart';
import 'package:ecom_app/features/cart/cart_bloc/ecom_cart_bloc.dart';
import 'package:ecom_app/features/favorites/favorite_bloc/ecom_favorite_bloc.dart';
import 'package:ecom_app/features/home/home_bloc/home_api_bloc/home_api_state_manager.dart';
import 'package:ecom_app/features/home/home_bloc/home_ui_bloc/module_home_bloc.dart';
import 'package:ecom_app/features/home/home_data/home_model.dart';
import 'package:ecom_app/features/product/product_bloc/product_detail_bloc.dart';
import 'package:ecom_app/features/search/search_bloc/search_bloc.dart';
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
  static Widget homeAppBar(BuildContext context) {
    return Padding(
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
              Bounceable(
                scaleFactor: 0.6,
                onTap: () async {
                  await Future.delayed(const Duration(milliseconds: 300));
                  if (!context.mounted) return;
                  Navigator.pushNamed(context, AppRoutes.cart);
                },
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
              SizedBox(width: 10.w), // Added spacing
              Bounceable(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.notifications),
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
                    Icons.notifications_outlined,
                    50),
              ),
            ],
          )
        ],
      ),
    );
  }

  //
  //======================= Bottom Bar ========================
  //
  static Widget homeBottomBar(
      int selectedIndex, ValueChanged<int> onBottomBarItemSelected) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onBottomBarItemSelected,
      backgroundColor: Colors.white,
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

  static Widget initPageWidget() {
    final CarouselController bannerController = CarouselController();
    final ValueNotifier<int> currentBannerIndex = ValueNotifier<int>(0);

    return BlocBuilder<HomeApiBloc, HomeApiState>(
      builder: (context, state) {
        if (state is HomeApiInitial) {
          context
              .read<HomeApiBloc>()
              .add(FetchHomePageProducts(limit: 4, page: 1));
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
                      child: CarouselSlider.builder(
                        carouselController: bannerController,
                        options: CarouselOptions(
                          height: 100.h,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            currentBannerIndex.value = index;
                          },
                        ),
                        itemCount: 5,
                        itemBuilder: (context, index, realIndex) {
                          final List<String> bannerImages = [
                            'assets/images/spclDiscountOne.png',
                            'assets/images/spclDiscountTwo.png',
                            'assets/images/spclDiscountThree.png',
                            'assets/images/spclDiscountTwo.png',
                            'assets/images/spclDiscountThree.png',
                          ];
                          return _buildBanner(bannerImages[index]);
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ValueListenableBuilder<int>(
                      valueListenable: currentBannerIndex,
                      builder: (context, index, child) {
                        return SmoothPageIndicator(
                          controller: PageController(initialPage: index),
                          count: 5,
                          effect: const ExpandingDotsEffect(
                            activeDotColor: Colors.orange,
                            dotHeight: 6,
                            dotWidth: 6,
                          ),
                        );
                      },
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

  static Widget _buildBanner(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }

  static Widget _buildSectionHeader() {
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

  static Widget homeProductList(HomeApiState state) {
    if (state is HomeApiLoading) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (state is HomeApiError) {
      return SliverToBoxAdapter(
        child: Expanded(
            child: Center(
                child: AppWidgets.ecomEmptyScreen(
                    Icons.timer_off_outlined, 'Error loading Products'))),
      );
    } else if (state is HomeApiLoaded) {
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final product = state.products[index];
              return BlocBuilder<FavoriteBloc, LikeState>(
                  builder: (context, likeValueState) {
                final islikeValue = likeValueState.likeBundles
                    .firstWhere((likeItem) => likeItem.id == product.id,
                        orElse: () => LikeBundle(
                            id: product.id,
                            title: product.title,
                            price: product.price,
                            image: product.image,
                            isLiked: false,
                            description: product.description,
                            rating: product.rating))
                    .isLiked;
                return Bounceable(
                  scaleFactor: 0.7,
                  onTap: () {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      Navigator.pushNamed(context, AppRoutes.productDetail,
                          arguments: CartBundle(
                              imageUrl: product.image,
                              title: product.title,
                              description: product.description,
                              price: product.price,
                              id: product.id));
                    });
                  },
                  child: Stack(children: [
                    AppWidgets.productItemWidget(
                        product.image,
                        product.title,
                        product.rating.rate,
                        product.rating.count,
                        product.price),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Bounceable(
                        scaleFactor: 0.6,
                        onTap: () {
                          context.read<FavoriteBloc>().add(ToggleLike(
                              id: product.id,
                              title: product.title,
                              image: product.image,
                              description: product.description,
                              price: product.price,
                              rating: Rating(
                                  rate: product.rating.rate,
                                  count: product.rating.count)));
                        },
                        child: Container(
                          padding: EdgeInsets.all(2.r),
                          width: 30.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Icon(
                            !islikeValue
                                ? Icons.favorite_border_outlined
                                : Icons.favorite,
                            color: Colors.orange,
                            size: 18.sp,
                          )),
                        ),
                      ),
                    )
                  ]),
                );
              });
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
  static Widget homeSearchBar(
    BuildContext context,
    FocusNode searchFocus,
    PageController pageController,
    VoidCallback onTextFieldTap,
    VoidCallback onFilterButtonTap,
  ) {
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
                onChanged: (value) {
                  pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                  context.read<HomeBloc>().updatePageindex(1);
                  context.read<SearchBloc>().add(SearchTextChanged(
                        text: value,
                      ));
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
              onFilterButtonTap();
            },
            child: AppWidgets.appIconTemplate(context, 0, 3.5, 15, 0, 45, 40,
                25, Colors.grey.withOpacity(0.2), Colors.black, Icons.tune, 50),
          )
        ]);
  }

  static Widget _textFieldWidgets() {
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
  static void showFilterBottomSheet(BuildContext context,
      FocusNode productNameFocus, FocusNode productCategoryFocus) {
    final homeApiBloc = context.read<HomeApiBloc>();
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
            BlocProvider.value(value: homeApiBloc),
            BlocProvider<SizeSelectionBloc>(
                create: (context) => SizeSelectionBloc()),
            BlocProvider<SliderValueCubit>(
                create: (context) => SliderValueCubit()),
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
                    _buildTextField(productNameFocus, 'Product Name',
                        'eg. Shirt', true, homeApiBloc),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Category',
                      style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    _buildTextField(productCategoryFocus, 'Category',
                        'eg. electronics', false, homeApiBloc),
                    SizedBox(height: 10.h),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Price Range',
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp)),
                        TextSpan(
                            text:
                                ' (Products with price lower than the set price will appear)',
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500))
                      ]),
                    ),
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
                              homeApiBloc.add(FilterProductList(
                                  text: '',
                                  price: value,
                                  isNameFieldActive: false,
                                  isPriceFieldActive: true,
                                  limit: 4,
                                  page: 1));
                            },
                          )),
                          Text('\$${value.toStringAsFixed(2)}'),
                        ],
                      );
                    }),
                    SizedBox(height: 10.h),
                    const Text('Select Size',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    BlocBuilder<SizeSelectionBloc, SizeSelectionState>(
                        builder: (context, state) {
                      return _buildSizeSelection(context, state);
                    }),
                    SizedBox(height: 20.h),
                    Bounceable(
                      scaleFactor: 0.6,
                      onTap: () {
                        homeApiBloc.add(FilterReset());
                      },
                      child: Container(
                          width: double.infinity,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 234, 163, 56),
                            borderRadius: BorderRadius.circular(22.w),
                          ),
                          child: Center(
                              child: Text(
                            'Reset',
                            style: GoogleFonts.montserrat(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ))),
                    ),
                    SizedBox(height: 30.h),
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

Widget _buildTextField(FocusNode textFocus, String label, String hint,
    bool isProdName, var homeApiBloc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextField(
      focusNode: textFocus,
      onChanged: (value) {
        homeApiBloc.add(FilterProductList(
            text: value,
            price: 0.0,
            isNameFieldActive: isProdName,
            isPriceFieldActive: false,
            limit: 4,
            page: 1));
      },
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
  return Padding(
    padding: EdgeInsets.only(top: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
    ),
  );
}
