import 'package:ecom_app/features/home/home_bloc/home_api_bloc/home_api_state_manager.dart';
import 'package:ecom_app/features/home/home_bloc/home_ui_bloc/module_home_bloc.dart';
import 'package:ecom_app/features/home/home_data/home_repository.dart';
import 'package:ecom_app/features/home/home_domain/home_usecase.dart';
import 'package:ecom_app/features/home/home_presentation/home_widgets/home_module_widgets.dart';
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
  PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        Provider<HomeRepository>(
          create: (context) => HomeRepositoryImpl(),
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
        // BlocProvider<HomeApiBloc>(
        //   create: (context) => HomeApiBloc(context.read<GetHomeUseCase>())
        //     ..add(FetchHomePageProducts(pageLimit: 1, limit: 4)),
        // ),
      ],
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
