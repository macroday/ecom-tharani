import 'package:ecom_app/features/home/home_bloc/module_home_bloc.dart';
import 'package:ecom_app/features/home/home_presentation/home_widgets/home_module_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EcomHomePage extends StatefulWidget {
  const EcomHomePage({super.key});

  @override
  State<EcomHomePage> createState() {
    return EcomHomeState();
  }
}

class EcomHomeState extends State<EcomHomePage> {
  PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(),
      child: BlocBuilder<HomeBloc, int>(builder: (context, selectedIndex) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  HomeModuleWidgets().homeAppBar(context),
                  HomeModuleWidgets().homeSearchBar(context),
                  Expanded(
                      child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      context.read<HomeBloc>().updatePageindex(index);
                    },
                    children: [
                      HomeModuleWidgets().initPageWidget(),
                      const Center(child: Text('Search Page')),
                      const Center(child: Text('Favorites Page')),
                      const Center(child: Text('History Page')),
                      const Center(child: Text('Profile Page')),
                    ],
                  )),
                ],
              ),
            ),
          ),
          bottomNavigationBar:
              HomeModuleWidgets().homeBottomBar(selectedIndex, (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            context.read<HomeBloc>().updatePageindex(index);
          }), // Bottom Nav Bar
        );
      }),
    );
  }
}
