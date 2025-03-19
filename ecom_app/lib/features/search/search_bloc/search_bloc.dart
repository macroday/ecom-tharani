import 'package:ecom_app/features/home/home_data/home_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//
//================== Bloc Base ===================
//
abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object> get props => [];
}

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

//
//================== Search Event ===================
//

class SearchTextChanged extends SearchEvent {
  final String text;
  const SearchTextChanged({
    required this.text,
  });
  @override
  List<Object> get props => [text];
}
//
//================== Search State ===================
//

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<HomeModel> searchResult;
  const SearchLoadedState({required this.searchResult});
  @override
  List<Object> get props => [searchResult];
}

class SearchErrorState extends SearchState {
  final String error;
  const SearchErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

//
//================== Search Bloc ===================
//

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<HomeModel> allProducts;
  SearchBloc(this.allProducts) : super(SearchInitialState()) {
    on<SearchTextChanged>((event, emit) {
      if (event.text.isEmpty) {
        emit(SearchInitialState());
        return;
      }
      final List<HomeModel> filteredProducts = event.text.length > 2
          ? allProducts
              .where((product) => product.category
                  .toLowerCase()
                  .contains(event.text.toLowerCase()))
              .toList()
          : [];
      if (filteredProducts.isEmpty) {
        emit(const SearchErrorState(error: 'No products found'));
      } else {
        emit(SearchLoadedState(searchResult: filteredProducts));
      }
    });
  }
}
