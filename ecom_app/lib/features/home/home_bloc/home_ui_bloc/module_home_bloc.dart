import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<int> {
  HomeBloc() : super(0);

  void updatePageindex(int pageIndex) {
    emit(pageIndex);
  }
}

class SliderValueCubit extends Cubit<double> {
  SliderValueCubit() : super(50.0);
  void updateSliderValue(double value) => emit(value);
}

class LikeValueCubit extends Cubit<Map<int, bool>> {
  LikeValueCubit() : super({});
  void updateLikeValue(int productId) {
    final newState = Map<int, bool>.from(state);
    newState[productId] = !(state[productId] ?? false);
    emit(newState);
  }
}
