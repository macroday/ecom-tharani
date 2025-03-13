import 'package:ecom_app/config/routes.dart';
import 'package:ecom_app/core/utils/ecom_common_widgets.dart';
import 'package:ecom_app/core/utils/ecom_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EcomFavoritesPage extends StatefulWidget {
  const EcomFavoritesPage({
    super.key,
  });

  @override
  State<EcomFavoritesPage> createState() {
    return EcomFavoritesState();
  }
}

class EcomFavoritesState extends State<EcomFavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: EcomConstants.ecomFavoriteList.isNotEmpty
              ? CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.r),
                        child: Row(children: [
                          Padding(
                              padding: EdgeInsets.only(left: 16.r),
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
                                  Colors.orange,
                                  Icons.favorite,
                                  50)),
                          Padding(
                            padding: EdgeInsets.only(left: 10.r),
                            child: Text(
                              'Favorites',
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Spacer(),
                          Bounceable(
                            scaleFactor: 0.6,
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                setState(() {
                                  EcomConstants.ecomFavoriteList.clear();
                                });
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 16.r),
                              child: Row(children: [
                                Text(
                                  'Remove',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                AppWidgets.appIconTemplate(
                                    context,
                                    0,
                                    0,
                                    0,
                                    0,
                                    35,
                                    30,
                                    20,
                                    Colors.grey.withOpacity(0.2),
                                    Colors.orange,
                                    Icons.delete_outline_rounded,
                                    50)
                              ]),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    SliverPadding(
                      padding:
                          EdgeInsets.only(left: 16.r, right: 16.r, top: 16.r),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Bounceable(
                              scaleFactor: 0.7,
                              onTap: () {
                                Future.delayed(
                                    const Duration(milliseconds: 300), () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.productDetail,
                                      arguments: EcomBundle(
                                          imageUrl: EcomConstants
                                              .ecomFavoriteList[index].image,
                                          title: EcomConstants
                                              .ecomFavoriteList[index].title,
                                          description: EcomConstants
                                              .ecomFavoriteList[index]
                                              .description,
                                          price: EcomConstants
                                              .ecomFavoriteList[index].price));
                                });
                              },
                              child: Stack(
                                children: [
                                  AppWidgets.productItemWidget(
                                    EcomConstants.ecomFavoriteList[index].image,
                                    EcomConstants.ecomFavoriteList[index].title,
                                    EcomConstants
                                        .ecomFavoriteList[index].rating.rate,
                                    EcomConstants
                                        .ecomFavoriteList[index].rating.count,
                                    EcomConstants.ecomFavoriteList[index].price,
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: EcomConstants.ecomFavoriteList.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    'No Favorites Found',
                    style: GoogleFonts.montserrat(
                        color: Colors.black, fontSize: 20.sp),
                  ),
                ),
        ),
      ),
    );
  }
}
