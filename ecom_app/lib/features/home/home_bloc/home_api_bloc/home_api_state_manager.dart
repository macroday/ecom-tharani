import 'package:ecom_app/core/utils/ecom_constants.dart';
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

class FilterProductList extends HomeApiEvent {
  final String text;
  final double price;
  final bool isNameFieldActive;
  final bool isPriceFieldActive;
  final int limit;
  final int page;
  FilterProductList(
      {required this.text,
      required this.price,
      required this.isNameFieldActive,
      required this.isPriceFieldActive,
      required this.limit,
      required this.page});
  @override
  List<Object?> get props =>
      [text, price, isNameFieldActive, isPriceFieldActive, limit, page];
}

class FilterReset extends HomeApiEvent {}
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
    on<FilterProductList>(_getFilteredList);
    on<FilterReset>(_resetProductList);
  }

  Future<void> _onFetchHomePageProducts(
      FetchHomePageProducts event, Emitter<HomeApiState> emit) async {
    debugPrint('************* _onFetchHomePageProducts CALLED *************');

    List<HomeModel> currentProducts = [];
    int nextPage = 1;
    bool isFirstFetch = state is HomeApiInitial;

    if (state is HomeApiLoaded) {
      final currentState = state as HomeApiLoaded;

      if (currentState.hasReachedMax) {
        debugPrint('************* REACHED MAX - NO MORE DATA *************');
        return;
      }

      currentProducts = currentState.products;
      nextPage = currentState.currentPage + 1;
    }

    if (isFirstFetch) {
      emit(HomeApiLoading());
    }

    try {
      debugPrint('************* Fetching Page: $nextPage *************');
      final products =
          await _getHomeUseCase(limit: event.limit, page: nextPage);

      if (products.isEmpty) {
        debugPrint('************* NO MORE PRODUCTS AVAILABLE *************');
        emit(HomeApiLoaded(
          products: currentProducts,
          hasReachedMax: true,
          currentPage: nextPage,
        ));
      } else {
        debugPrint(
            '************* PRODUCTS ADDED TO EXISTING LIST *************');
        emit(HomeApiLoaded(
          products: [...currentProducts, ...products],
          hasReachedMax: products.length < event.limit,
          currentPage: nextPage,
        ));
      }
    } catch (error) {
      debugPrint('************* ERROR FETCHING PRODUCTS: $error *************');
      emit(HomeApiError(errorMessage: 'Failed to fetch products: $error'));
    }
  }

  Future<void> _getFilteredList(
      FilterProductList event, Emitter<HomeApiState> emit) async {
    List<HomeModel> allProducts = [];
    if (event.text.isEmpty && !event.isPriceFieldActive) {
      if (state is HomeApiLoaded) {
        final currentState = state as HomeApiLoaded;
        emit(HomeApiLoaded(
          products: currentState.products,
          hasReachedMax: currentState.hasReachedMax,
          currentPage: currentState.currentPage,
        ));
      } else {
        emit(HomeApiInitial());
      }
      return;
    }
    allProducts = ProductUtils.ecomProductList;
    final List<HomeModel> filteredProducts = allProducts.where((product) {
      bool matchesName = event.isNameFieldActive
          ? product.title.toLowerCase().contains(event.text.toLowerCase())
          : true;

      bool matchesCategory = !event.isNameFieldActive
          ? product.category.toLowerCase().contains(event.text.toLowerCase())
          : true;

      bool matchesPrice =
          event.isPriceFieldActive ? product.price < event.price : true;

      return matchesName && matchesCategory && matchesPrice;
    }).toList();
    if (filteredProducts.isEmpty) {
      emit(HomeApiError(errorMessage: 'No Products found'));
    } else {
      emit(HomeApiLoaded(
          products: filteredProducts, hasReachedMax: true, currentPage: 1));
    }
  }

  Future<void> _resetProductList(
      FilterReset event, Emitter<HomeApiState> emit) async {
    emit(HomeApiInitial());
    add(FetchHomePageProducts(limit: 30, page: 1));
  }
}
