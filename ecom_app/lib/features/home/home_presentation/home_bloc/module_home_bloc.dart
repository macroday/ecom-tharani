import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<int> {
  HomeBloc() : super(0);

  void updatePageindex(int pageIndex) {
    emit(pageIndex);
  }
}
