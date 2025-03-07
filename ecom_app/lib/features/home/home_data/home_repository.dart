import 'package:dio/dio.dart';
import 'package:ecom_app/features/home/home_data/home_model.dart';

abstract class HomeRepository {
  Future<List<HomeModel>> fetchHomePageProducts(int page, int limit);
}

class HomeRepositoryImpl extends HomeRepository {
  final Dio _dio = Dio();
  @override
  Future<List<HomeModel>> fetchHomePageProducts(int page, int limit) async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products');
      if (response.statusCode == 200) {
        return response.data
            .map((jsonData) => HomeModel.fromJson(jsonData))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (exception) {
      throw Exception('Error fetching products: $exception');
    }
  }
}
