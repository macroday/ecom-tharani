import 'package:dio/dio.dart';
import 'package:ecom_app/core/utils/ecom_constants.dart';
import 'package:ecom_app/features/home/home_data/home_model.dart';

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
      final response = await _dio.get(EcomConstants.ecomApiUrl,
          queryParameters: {'limit': limit, 'page': page});
      print('**********RESPONSE : ${response.statusCode}**********');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((jsonData) => HomeModel.fromJson(jsonData))
            .toList();
      } else {
        print('**********RESPONSE FAILED**********');
        throw Exception('Failed to load products');
      }
    } catch (exception) {
      print('**********RESPONSE FAILED**********');
      throw Exception('Error fetching products: $exception');
    }
  }
}
