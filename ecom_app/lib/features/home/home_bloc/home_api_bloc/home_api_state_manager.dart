import 'package:ecom_app/features/home/home_data/home_model.dart';
import 'package:ecom_app/features/home/home_domain/home_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//
//====================== Event ===========================
//

abstract class HomeApiEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchHomePageProducts extends HomeApiEvent {
  final int limit;
  final int page;
  FetchHomePageProducts({required this.limit, required this.page});
  @override
  List<Object?> get props => [limit, page];
}

//
//======================== State ===========================
//

abstract class HomeApiState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeApiInitial extends HomeApiState {}

class HomeApiLoading extends HomeApiState {}

class HomeApiLoaded extends HomeApiState {
  final List<HomeModel> products;
  final bool hasReachedMax;
  final int currentPage;
  HomeApiLoaded(
      {required this.products,
      required this.hasReachedMax,
      required this.currentPage});
  @override
  List<Object?> get props => [products, hasReachedMax, currentPage];
}

class HomeApiError extends HomeApiState {
  final String errorMessage;
  HomeApiError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

//
//========================= Bloc ===========================
//

class HomeApiBloc extends Bloc<HomeApiEvent, HomeApiState> {
  final GetHomeUseCase _getHomeUseCase;
  HomeApiBloc(this._getHomeUseCase) : super(HomeApiInitial()) {
    on<FetchHomePageProducts>(_onFetchHomePageProducts);
  }

  Future<void> _onFetchHomePageProducts(
      FetchHomePageProducts event, Emitter<HomeApiState> emit) async {
    print('************* _onFetchHomePageProducts CALLED *************');

    if (state is HomeApiLoaded) {
      print('************* HOMEAPI LOADED *************');
      final currentState = state as HomeApiLoaded;
      if (currentState.hasReachedMax) {
        return;
      }
    }

    try {
      if (state is HomeApiInitial) {
        print('************* HOMEAPI INITIAL *************');
        emit(HomeApiLoading());
      }

      if (state is HomeApiLoading) {
        print('************* HOMEAPI LOADING *************');
      }
      var products =
          await _getHomeUseCase(limit: event.limit, page: event.page);
      print('************* Products Received: *************');
      if (products.isEmpty) {
        emit(HomeApiLoaded(
            products: [], hasReachedMax: true, currentPage: event.page));
      } else {
        final List<HomeModel> currentProducts =
            state is HomeApiLoaded ? (state as HomeApiLoaded).products : [];
        emit(HomeApiLoaded(
            products: currentProducts + products,
            hasReachedMax: products.length < event.limit,
            currentPage: event.page));
      }
    } catch (error) {
      print('************* No products available *************');
      emit(HomeApiError(errorMessage: 'Failed to fetch products : $error'));
    }
  }
}
