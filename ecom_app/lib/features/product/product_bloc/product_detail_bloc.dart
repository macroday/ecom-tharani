import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//
//====================== Product Detail Screen Bloc Base ====================
//
abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();
  @override
  List<Object?> get props => [];
}

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();
  @override
  List<Object?> get props => [];
}

//
//====================== Product Suggestion Bloc ======================
//

class ImageSuggestionEvent extends ProductDetailEvent {
  final int selectdImageIndex;
  const ImageSuggestionEvent({required this.selectdImageIndex});

  @override
  List<Object?> get props => [selectdImageIndex];
}

class ImageSuggestionState extends ProductDetailState {
  final int selectdImageIndex;
  const ImageSuggestionState({required this.selectdImageIndex});

  ImageSuggestionState copyWith({int? selectedIndex}) {
    return ImageSuggestionState(
        selectdImageIndex: selectedIndex ?? selectdImageIndex);
  }

  @override
  List<Object?> get props => [selectdImageIndex];
}

class ImageSuggestionBloc
    extends Bloc<ImageSuggestionEvent, ImageSuggestionState> {
  ImageSuggestionBloc()
      : super(const ImageSuggestionState(selectdImageIndex: 0)) {
    on<ImageSuggestionEvent>(
        (ImageSuggestionEvent event, Emitter<ImageSuggestionState> emit) async {
      emit(state.copyWith(selectedIndex: event.selectdImageIndex));
    });
  }
}

//
//====================== Size Selection Bloc ======================
//

class SizeSelectionEvent extends ProductDetailEvent {
  final int sizeIndex;
  const SizeSelectionEvent({required this.sizeIndex});
  @override
  List<Object?> get props => [sizeIndex];
}

class SizeSelectionState extends ProductDetailState {
  final int sizeIndex;
  const SizeSelectionState({required this.sizeIndex});
  SizeSelectionState updateSizeSelection({int? selectedSizeIndex}) {
    return SizeSelectionState(sizeIndex: selectedSizeIndex ?? sizeIndex);
  }

  @override
  List<Object?> get props => [sizeIndex];
}

class SizeSelectionBloc extends Bloc<SizeSelectionEvent, SizeSelectionState> {
  SizeSelectionBloc() : super(const SizeSelectionState(sizeIndex: 0)) {
    on<SizeSelectionEvent>(
        (SizeSelectionEvent event, Emitter<SizeSelectionState> emit) {
      emit(state.updateSizeSelection(selectedSizeIndex: event.sizeIndex));
    });
  }
}

//
//====================== Product Quantity Bloc ======================
//

class ProductQuantityEvent extends ProductDetailEvent {
  final int quantity;
  const ProductQuantityEvent({required this.quantity});
  @override
  List<Object?> get props => [quantity];
}

class ProductQuantityState extends ProductDetailState {
  final int quantity;
  const ProductQuantityState({required this.quantity});
  ProductQuantityState updateQuantity({int? updatedQuantity}) {
    return ProductQuantityState(quantity: updatedQuantity ?? quantity);
  }

  @override
  List<Object?> get props => [quantity];
}

class ProductQuantityBloc
    extends Bloc<ProductQuantityEvent, ProductQuantityState> {
  ProductQuantityBloc() : super(const ProductQuantityState(quantity: 1)) {
    on<ProductQuantityEvent>(
        (ProductQuantityEvent event, Emitter<ProductQuantityState> emit) {
      emit(state.updateQuantity(updatedQuantity: event.quantity));
    });
  }
}

//
//====================== Product Description Cubit ======================
//

class DescriptionCubit extends Cubit<bool> {
  DescriptionCubit() : super(true);

  void toggleDescription() => emit(!state);
}

class CartValueCubit extends Cubit<Map<int, bool>> {
  CartValueCubit() : super({});
  void updateCartValue(int productId) {
    final newState = Map<int, bool>.from(state);
    newState[productId] = !(state[productId] ?? false);
    emit(newState);
  }
}
