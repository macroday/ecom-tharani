import 'package:ecom_app/config/routes.dart';
import 'package:ecom_app/core/utils/ecom_constants.dart';
import 'package:ecom_app/features/onBoarding/on_boarding_presentation/onBoarding_bloc/get_started_drag_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class GetOnBoardingScreen extends StatelessWidget {
  const GetOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return getOnBoardingScreen(context, size);
  }
}

Widget getOnBoardingScreen(BuildContext context, Size size) {
  return SafeArea(
    child: Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned.fill(
              child: _buildImageCollage(),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.w),
                      topRight: Radius.circular(12.w)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.91),
                      Colors.white,
                      Colors.white,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    _buildTextSection(),
                    SizedBox(height: 30.h),
                    Container(
                        margin: EdgeInsets.only(right: 80.r),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.home);
                            },
                            child: _buildGetStartedButton(context))),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildImageCollage() {
  return BlocProvider(
    create: (_) => ImageCollageCubit(),
    child: Builder(builder: (context) {
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateZ(0.18)
            ..translate(-25.w, -30.h),
          child: BlocBuilder<ImageCollageCubit, ScrollController>(
            builder: (context, scrollController) {
              return StaggeredGridView.countBuilder(
                controller: scrollController,
                crossAxisCount: 3,
                itemCount: EcomConstants.imageList.length * 10,
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                itemBuilder: (context, index) {
                  return _buildImage(EcomConstants
                      .imageList[index % EcomConstants.imageList.length]);
                },
                staggeredTileBuilder: (int index) => StaggeredTile.count(
                    (index % 17 == 0) ? 3 : 1, (index % 2 == 0) ? 1 : 3),
              );
            },
          ),
        ),
      );
    }),
  );
}

Widget _buildImage(String assetPath) {
  return SizedBox(
    width: double.infinity,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12.w),
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget _buildTextSection() {
  return SizedBox(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.r, right: 100.r),
          child: Text(
            'Get access to your',
            style: GoogleFonts.montserrat(
                fontSize: 35.sp,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.r, right: 100.r),
          child: Row(children: [
            Text(
              'finances',
              style: GoogleFonts.montserrat(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 234, 163, 56)),
            ),
            Text(
              ' anytime!',
              style: GoogleFonts.montserrat(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ]),
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: EdgeInsets.only(left: 15.r, right: 100.r),
          child: Text(
            'Discover your own luxury fashion',
            style: GoogleFonts.montserrat(
              fontSize: 16.sp,
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.r, right: 100.r),
          child: Text(
            'style and change the quality',
            style: GoogleFonts.montserrat(
              fontSize: 16.sp,
              color: Colors.grey,
            ),
          ),
        )
      ],
    ),
  );
}

Widget _buildGetStartedButton(BuildContext context) {
  return BlocProvider(
    create: (_) => GetStartedCubit(),
    child: BlocBuilder<GetStartedCubit, GetStartedState>(
        builder: (context, state) {
      return Container(
        width: 320.w,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.w),
          color: state.isAtEnd
              ? const Color.fromARGB(255, 234, 163, 56)
              : Colors.transparent,
          border: Border.all(color: const Color.fromARGB(255, 234, 163, 56)),
        ),
        child: Stack(
          children: [
            Positioned(
              left: state.position,
              top: 5,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  context
                      .read<GetStartedCubit>()
                      .updatePosition(details.delta.dx);
                },
                onHorizontalDragEnd: (_) {
                  context.read<GetStartedCubit>().checkNavigation(() {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  });
                },
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 234, 163, 56),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100.w,
                  ),
                  Text(
                    'Get Started',
                    style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 234, 163, 56),
                    ),
                  ),
                  SizedBox(width: 30.w),
                  const Icon(Icons.chevron_right,
                      color: Color.fromARGB(180, 234, 163, 56), size: 18),
                  const Icon(Icons.chevron_right,
                      color: Color.fromARGB(220, 234, 163, 56), size: 20),
                  const Icon(Icons.chevron_right,
                      color: Color.fromARGB(255, 234, 163, 56), size: 22),
                ],
              ),
            ),
          ],
        ),
      );
    }),
  );
}
