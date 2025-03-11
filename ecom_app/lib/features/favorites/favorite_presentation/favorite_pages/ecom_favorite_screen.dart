import 'package:flutter/material.dart';

class EcomFavoritesPage extends StatefulWidget {
  const EcomFavoritesPage({super.key});

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
          child: const Center(
            child: Text('Favorite Screen'),
          ),
        ),
      ),
    );
  }
}
