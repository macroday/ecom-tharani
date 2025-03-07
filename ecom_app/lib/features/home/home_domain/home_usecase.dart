import 'package:ecom_app/features/home/home_data/home_model.dart';
import 'package:ecom_app/features/home/home_data/home_repository.dart';

class GetHomeUseCase {
  final HomeRepository _homeRepository;
  GetHomeUseCase(this._homeRepository);

  Future<List<HomeModel>> call({required int page, required int limit}) {
    return _homeRepository.fetchHomePageProducts(page, limit);
  }
}
