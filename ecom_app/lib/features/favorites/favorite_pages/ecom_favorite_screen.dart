import 'package:ecom_app/config/routes.dart';
import 'package:ecom_app/core/utils/ecom_common_widgets.dart';
import 'package:ecom_app/core/utils/ecom_constants.dart';
import 'package:ecom_app/features/favorites/favorite_bloc/ecom_favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EcomFavoritesPage extends StatelessWidget {
  const EcomFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child:
                BlocBuilder<FavoriteBloc, LikeState>(builder: (context, state) {
              return state.likeBundles.isNotEmpty
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
                                  context
                                      .read<FavoriteBloc>()
                                      .add(RemoveLikeList());
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
                            padding: EdgeInsets.only(
                                left: 16.r, right: 16.r, top: 16.r),
                            sliver: SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return Bounceable(
                                    scaleFactor: 0.7,
                                    onTap: () {
                                      Future.delayed(
                                          const Duration(milliseconds: 300),
                                          () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.productDetail,
                                            arguments: EcomBundle(
                                                imageUrl: state
                                                    .likeBundles[index].image,
                                                title: state
                                                    .likeBundles[index].title,
                                                description: state
                                                    .likeBundles[index]
                                                    .description,
                                                price: state
                                                    .likeBundles[index].price,
                                                id: state
                                                    .likeBundles[index].id));
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        AppWidgets.productItemWidget(
                                          state.likeBundles[index].image,
                                          state.likeBundles[index].title,
                                          state.likeBundles[index].rating.rate,
                                          state.likeBundles[index].rating.count,
                                          state.likeBundles[index].price,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                childCount: state.likeBundles.length,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                            )),
                      ],
                    )
                  : Column(children: [
                      Expanded(
                          child: AppWidgets.ecomEmptyScreen(
                              Icons.favorite_border_outlined,
                              'No Favorites Found'))
                    ]);
            })),
      ),
    );
  }
}
