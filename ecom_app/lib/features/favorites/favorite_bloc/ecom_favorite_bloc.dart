import 'package:ecom_app/features/home/home_data/home_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//model
class LikeBundle {
  final int id;
  final String title;
  final double price;
  final String image;
  final bool isLiked;
  final String description;
  final Rating rating;
  const LikeBundle(
      {required this.id,
      required this.title,
      required this.price,
      required this.image,
      this.isLiked = false,
      this.description = '',
      required this.rating});

  LikeBundle copyWith({required bool isLiked}) {
    return LikeBundle(
        id: id,
        title: title,
        price: price,
        image: image,
        isLiked: isLiked,
        description: description,
        rating: rating);
  }
}

//event
class LikeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleLike extends LikeEvent {
  final int id;
  final String title;
  final String image;
  final String description;
  final double price;
  final Rating rating;
  ToggleLike(
      {required this.id,
      required this.title,
      required this.image,
      required this.description,
      required this.price,
      required this.rating});
  @override
  List<Object?> get props => [id, title, image, description, price, rating];
}

class RemoveLikeList extends LikeEvent {
  RemoveLikeList();
  @override
  List<Object?> get props => [];
}

//state
class LikeState extends Equatable {
  final List<LikeBundle> likeBundles;
  final bool hasLikedItems;
  const LikeState({required this.likeBundles, required this.hasLikedItems});

  factory LikeState.initial() {
    return const LikeState(likeBundles: [], hasLikedItems: false);
  }

  LikeState copyWith(List<LikeBundle>? likeBundles, bool? hasLikedItems) {
    return LikeState(
        likeBundles: likeBundles ?? this.likeBundles,
        hasLikedItems: hasLikedItems ?? this.hasLikedItems);
  }

  @override
  List<Object?> get props => [likeBundles, hasLikedItems];
}

//bloc
class FavoriteBloc extends Bloc<LikeEvent, LikeState> {
  FavoriteBloc() : super(LikeState.initial()) {
    on<ToggleLike>((event, emit) {
      final List<LikeBundle> updatedLikeBundle =
          List<LikeBundle>.from(state.likeBundles);

      final existingIndex =
          updatedLikeBundle.indexWhere((likeItem) => likeItem.id == event.id);

      if (existingIndex != -1) {
        updatedLikeBundle.removeAt(existingIndex);
      } else {
        final product = state.likeBundles.firstWhere(
            (likeItem) => likeItem.id == event.id,
            orElse: () => LikeBundle(
                id: event.id,
                title: event.title,
                price: event.price,
                image: event.image,
                isLiked: true,
                description: event.description,
                rating: event.rating));
        updatedLikeBundle.add(product.copyWith(isLiked: true));
      }

      emit(state.copyWith(updatedLikeBundle, updatedLikeBundle.isNotEmpty));
    });

    on<RemoveLikeList>((event, emit) {
      final List<LikeBundle> ogLikeBundle =
          List<LikeBundle>.from(state.likeBundles);
      ogLikeBundle.clear();
      emit(state.copyWith(ogLikeBundle, false));
    });
  }
}
