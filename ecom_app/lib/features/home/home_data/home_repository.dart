import 'package:dio/dio.dart';
import 'package:ecom_app/core/utils/ecom_constants.dart';
import 'package:ecom_app/features/home/home_data/home_model.dart';
import 'package:flutter/material.dart';

abstract class HomeRepository {
  Future<List<HomeModel>> fetchHomePageProducts(
      {required int limit, required int page});
}

class HomeRepositoryImpl extends HomeRepository {
  final Dio _dio = Dio();

  @override
  Future<List<HomeModel>> fetchHomePageProducts(
      {required int limit, required int page}) async {
    try {
      final response = await _dio.get(EcomConstants.ecomApiUrl);

      debugPrint(
          '********** RESPONSE STATUS: ${response.statusCode} **********');

      if (response.statusCode == 200) {
        final allProducts = (response.data as List)
            .map((jsonData) => HomeModel.fromJson(jsonData))
            .toList();
        final startIndex = (page - 1) * limit;
        final endIndex = startIndex + limit;

        final paginatedProducts = allProducts.sublist(
          startIndex,
          endIndex > allProducts.length ? allProducts.length : endIndex,
        );

        return paginatedProducts;
      } else {
        debugPrint('********** RESPONSE FAILED **********');
        throw Exception('Failed to load products');
      }
    } catch (exception) {
      debugPrint('********** RESPONSE FAILED **********');
      throw Exception('Error fetching products: $exception');
    }
  }
}
