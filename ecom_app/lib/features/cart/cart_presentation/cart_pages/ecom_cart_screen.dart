import 'package:flutter/material.dart';

class EcomCartPage extends StatefulWidget {
  const EcomCartPage({super.key});

  @override
  State<EcomCartPage> createState() {
    return EcomCartState();
  }
}

class EcomCartState extends State<EcomCartPage> {
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
            child: Text('Cart Screen'),
          ),
        ),
      ),
    );
  }
}
