import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Cart Bundle
class CartBundle {
  final int id;
  final String title;
  final String imageUrl;
  final double price;
  final String description;
  int quantity;
  bool isSelected;

  CartBundle({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
    this.quantity = 1,
    this.isSelected = false,
  });

  CartBundle copyWith({int? quantity, bool? isSelected}) {
    return CartBundle(
        id: id,
        title: title,
        imageUrl: imageUrl,
        price: price,
        description: description,
        quantity: quantity ?? this.quantity,
        isSelected: isSelected ?? this.isSelected);
  }
}

// Events
abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddItem extends CartEvent {
  final CartBundle item;
  AddItem(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveSelectedItems extends CartEvent {}

class ToggleSelection extends CartEvent {
  final String itemId;
  ToggleSelection(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class IncreaseQuantity extends CartEvent {
  final String itemId;
  IncreaseQuantity(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class DecreaseQuantity extends CartEvent {
  final String itemId;
  DecreaseQuantity(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

// State
class CartState extends Equatable {
  final List<CartBundle> cartItems;
  final double totalPrice;
  final double grandTotal;
  final bool hasSelectedItems;

  const CartState({
    required this.cartItems,
    required this.totalPrice,
    required this.grandTotal,
    required this.hasSelectedItems,
  });

  factory CartState.initial() {
    return const CartState(
      cartItems: [],
      totalPrice: 0.0,
      grandTotal: 0.0,
      hasSelectedItems: false,
    );
  }

  CartState copyWith({
    List<CartBundle>? cartItems,
    double? totalPrice,
    double? grandTotal,
    bool? hasSelectedItems,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
      grandTotal: grandTotal ?? this.grandTotal,
      hasSelectedItems: hasSelectedItems ?? this.hasSelectedItems,
    );
  }

  @override
  List<Object?> get props =>
      [cartItems, totalPrice, grandTotal, hasSelectedItems];
}

// bloc
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<AddItem>((event, emit) {
      final List<CartBundle> updatedCart;
      if ((state.cartItems.indexWhere((item) => item.id == event.item.id)) !=
          -1) {
        final indexOfExistingItem =
            state.cartItems.indexWhere((item) => item.id == event.item.id);
        updatedCart = List<CartBundle>.from(state.cartItems);
        updatedCart[indexOfExistingItem] =
            updatedCart[indexOfExistingItem].copyWith(
          quantity: updatedCart[indexOfExistingItem].quantity + 1,
        );
      } else {
        updatedCart = List<CartBundle>.from(state.cartItems)..add(event.item);
      }

      _emitUpdatedCart(emit, updatedCart);
    });

    on<ToggleSelection>((event, emit) {
      final updatedCart = state.cartItems.map((item) {
        if (item.id.toString() == event.itemId) {
          return item.copyWith(isSelected: !item.isSelected);
        }
        return item;
      }).toList();
      _emitUpdatedCart(emit, updatedCart);
    });

    on<RemoveSelectedItems>((event, emit) {
      final updatedCart =
          state.cartItems.where((item) => !item.isSelected).toList();
      _emitUpdatedCart(emit, updatedCart);
    });

    on<IncreaseQuantity>((event, emit) {
      final updatedCart = state.cartItems.map((item) {
        debugPrint('Checking item: ${item.id} with event ID: ${event.itemId}');
        if (item.id.toString() == event.itemId) {
          return item.copyWith(quantity: item.quantity + 1);
        }
        return item;
      }).toList();
      _emitUpdatedCart(emit, updatedCart);
    });

    on<DecreaseQuantity>((event, emit) {
      final updatedCart = state.cartItems.map((item) {
        debugPrint('Checking item: ${item.id} with event ID: ${event.itemId}');
        if (item.id.toString() == event.itemId && item.quantity > 1) {
          return item.copyWith(quantity: item.quantity - 1);
        }
        return item;
      }).toList();
      _emitUpdatedCart(emit, updatedCart);
    });
  }

  void _emitUpdatedCart(Emitter<CartState> emit, List<CartBundle> updatedCart) {
    double totalPrice =
        updatedCart.fold(0, (sum, item) => sum + (item.price * item.quantity));
    double grandTotal = totalPrice + 5;
    bool hasSelectedItems = updatedCart.any((item) => item.isSelected);

    emit(state.copyWith(
      cartItems: updatedCart,
      totalPrice: totalPrice,
      grandTotal: grandTotal,
      hasSelectedItems: hasSelectedItems,
    ));
  }
}
