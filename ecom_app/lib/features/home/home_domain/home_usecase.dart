import 'package:ecom_app/features/home/home_data/home_model.dart';
import 'package:ecom_app/features/home/home_data/home_repository.dart';
import 'package:flutter/material.dart';

class GetHomeUseCase {
  final HomeRepository _homeRepository;
  GetHomeUseCase(this._homeRepository);

  Future<List<HomeModel>> call({required int limit, required int page}) {
    debugPrint('Calling UseCase...');
    return _homeRepository.fetchHomePageProducts(limit: limit, page: page);
  }
}
