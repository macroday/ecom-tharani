import 'package:ecom_app/features/home/home_data/home_model.dart';

class EcomConstants {
  static const imageList = [
    'assets/images/mens_wear.jpg',
    'assets/images/british_fashion_ad.jpg',
    'assets/images/men_fashion_ad.jpeg',
    'assets/images/onBoarding_shirt.jpeg',
    'assets/images/onBoarding_sunglasses.jpeg',
    'assets/images/women_dress.jpg',
    'assets/images/mens_wear.jpg',
    'assets/images/british_fashion_ad.jpg',
    'assets/images/men_fashion_ad.jpeg',
    'assets/images/onBoarding_shirt.jpeg',
    'assets/images/onBoarding_sunglasses.jpeg',
    'assets/images/women_dress.jpg',
    'assets/images/mens_wear.jpg',
    'assets/images/british_fashion_ad.jpg',
    'assets/images/men_fashion_ad.jpeg',
    'assets/images/onBoarding_shirt.jpeg',
    'assets/images/onBoarding_sunglasses.jpeg',
    'assets/images/women_dress.jpg',
  ];

  static const ecomApiUrl = 'https://fakestoreapi.com/products';
  static const ecomHomePath = '/home';
  static const ecomProductPath = '/product';
  static const ecomCartPath = '/cart';
  static const ecomFavoritePath = '/favorites';
  static const searchCategories = [
    'Men\'s Clothing',
    'Women\'s Clothing',
  ];
  static const checkOutPath = '/checkOut';
  static const notificationPath = '/notification';
}

class EcomBundle {
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final int id;

  EcomBundle(
      {required this.imageUrl,
      required this.title,
      required this.description,
      required this.price,
      required this.id});
}

class ProductUtils {
  static List<HomeModel> ecomProductList = [];
}
