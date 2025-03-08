import 'package:ecom_app/features/home/home_presentation/home_pages/ecom_home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<int> {
  HomeBloc() : super(0);

  void updatePageindex(int pageIndex) {
    emit(pageIndex);
  }
}
