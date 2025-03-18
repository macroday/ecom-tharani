import 'package:ecom_app/core/utils/ecom_common_widgets.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child: Column(children: [
              Expanded(
                  child: AppWidgets.ecomEmptyScreen(
                      Icons.person, 'No Profile Data'))
            ])),
      ),
    );
  }
}
