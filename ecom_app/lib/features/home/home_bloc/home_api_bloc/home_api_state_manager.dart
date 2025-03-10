import 'package:ecom_app/features/home/home_data/home_model.dart';
import 'package:ecom_app/features/home/home_domain/home_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    debugPrint('************* _onFetchHomePageProducts CALLED *************');

    List<HomeModel> currentProducts = [];
    int nextPage = 1;

    if (state is HomeApiLoaded) {
      debugPrint('************* HOMEAPI LOADED *************');
      final currentState = state as HomeApiLoaded;

      if (currentState.hasReachedMax) {
        debugPrint('************* REACHED MAX - NO MORE DATA *************');
        return;
      }

      currentProducts = List.from(currentState.products);
      nextPage = currentState.currentPage + 1;
    }

    try {
      if (state is HomeApiInitial) {
        debugPrint('************* HOMEAPI INITIAL *************');
        emit(HomeApiLoading());
      }

      if (state is HomeApiLoading) {
        debugPrint('************* HOMEAPI LOADING *************');
      }

      debugPrint('************* Fetching Page: $nextPage *************');
      var products = await _getHomeUseCase(limit: event.limit, page: nextPage);

      debugPrint(
          '************* Products Received: ${products.length} *************');

      if (products.isEmpty) {
        debugPrint('************* NO MORE PRODUCTS AVAILABLE *************');
        emit(HomeApiLoaded(
          products: currentProducts,
          hasReachedMax: true,
          currentPage: nextPage,
        ));
      } else {
        debugPrint(
            '************* PRODUCTS ADDED TO EXISTING LIST : ${products as List} *************');
        emit(HomeApiLoaded(
          products: currentProducts + products,
          hasReachedMax: products.length < event.limit,
          currentPage: nextPage,
        ));
      }
    } catch (error) {
      debugPrint('************* ERROR FETCHING PRODUCTS: $error *************');
      emit(HomeApiError(errorMessage: 'Failed to fetch products : $error'));
    }
  }
}
