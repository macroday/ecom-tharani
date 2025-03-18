import 'package:ecom_app/core/utils/ecom_product_utils.dart';
import 'package:ecom_app/features/favorites/favorite_pages/ecom_favorite_screen.dart';
import 'package:ecom_app/features/history/history_screen.dart';
import 'package:ecom_app/features/home/home_bloc/home_api_bloc/home_api_state_manager.dart';
import 'package:ecom_app/features/home/home_bloc/home_ui_bloc/module_home_bloc.dart';
import 'package:ecom_app/features/home/home_data/home_repository.dart';
import 'package:ecom_app/features/home/home_domain/home_usecase.dart';
import 'package:ecom_app/features/home/home_pages/home_module_widgets.dart';
import 'package:ecom_app/features/profile/profile_screen.dart';
import 'package:ecom_app/features/search/search_bloc/search_bloc.dart';
import 'package:ecom_app/features/search/searh_pages/ecom_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class EcomHomePage extends StatefulWidget {
  const EcomHomePage({super.key});

  @override
  State<EcomHomePage> createState() {
    return EcomHomeState();
  }
}

class EcomHomeState extends State<EcomHomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  FocusNode searchFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    searchFocus = FocusNode();
    searchFocus.addListener(() {
      if (searchFocus.hasFocus) {
        _pageController.animateToPage(1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    searchFocus.dispose();
  }

  void _navigateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        Provider<HomeRepository>(
          create: (_) => HomeRepositoryImpl(),
        ),
        Provider<GetHomeUseCase>(
          create: (context) => GetHomeUseCase(context.read<HomeRepository>()),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
        BlocProvider<HomeApiBloc>(
          create: (context) => HomeApiBloc(context.read<GetHomeUseCase>()),
        ),
        BlocProvider<SearchBloc>(
          create: (_) => SearchBloc(ProductUtils.ecomProductList),
        ),
      ],
      child: BlocBuilder<HomeBloc, int>(builder: (context, selectedIndex) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: GestureDetector(
              onTap: () {
                searchFocus.unfocus();
              },
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    HomeModuleWidgets.homeAppBar(context),
                    HomeModuleWidgets.homeSearchBar(
                        context, searchFocus, _pageController, () {
                      _navigateToPage(1);
                      context.read<HomeBloc>().updatePageindex(1);
                      searchFocus.requestFocus();
                    }),
                    Expanded(
                        child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        context.read<HomeBloc>().updatePageindex(index);
                      },
                      children: [
                        HomeModuleWidgets.initPageWidget(),
                        EcomSearchScreen(
                          productList: ProductUtils.ecomProductList,
                        ),
                        const EcomFavoritesPage(),
                        const HistoryScreen(),
                        const ProfileScreen(),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar:
              HomeModuleWidgets.homeBottomBar(selectedIndex, (index) {
            _navigateToPage(index);
            context.read<HomeBloc>().updatePageindex(index);
          }),
        );
      }),
    );
  }
}
