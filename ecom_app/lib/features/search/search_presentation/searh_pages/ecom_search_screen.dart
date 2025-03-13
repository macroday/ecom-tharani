import 'package:ecom_app/features/home/home_data/home_model.dart';
import 'package:ecom_app/features/search/search_presentation/search_widgets/ecom_search_widgets.dart';
import 'package:flutter/material.dart';

class EcomSearchScreen extends StatefulWidget {
  final List<HomeModel> productList;
  const EcomSearchScreen({super.key, required this.productList});

  @override
  State<EcomSearchScreen> createState() {
    return EcomSearchState();
  }
}

class EcomSearchState extends State<EcomSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidgets().buildCategoryList(context),
            Expanded(child: SearchWidgets().searchPageContent(context)),
          ],
        ),
      ),
    );
  }
}
