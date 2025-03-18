import 'package:ecom_app/features/home/home_data/home_model.dart';
import 'package:ecom_app/features/search/searh_pages/ecom_search_widgets.dart';
import 'package:flutter/material.dart';

class EcomSearchScreen extends StatelessWidget {
  final List<HomeModel> productList;
  const EcomSearchScreen({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidgets.buildCategoryList(context),
            Expanded(child: SearchWidgets.searchPageContent(context)),
          ],
        ),
      ),
    );
  }
}
