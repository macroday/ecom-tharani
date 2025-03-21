import 'package:dio/dio.dart';
import 'package:ecom_app/core/utils/ecom_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ButtonClick extends LoginEvent {}

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ButtonState extends LoginState {
  final String email;
  final String password;
  ButtonState({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class LoginBloc extends Bloc<ButtonClick, ButtonState> {
  LoginBloc() : super(ButtonState(email: '', password: '')) {
    on<ButtonClick>((ButtonClick event, Emitter<ButtonState> emit) async {
      final Dio dio = Dio();
      final response = await dio.get(EcomConstants.ecomApiUrl);
      if (response.statusCode == 200) {
        debugPrint('################### LOGIN SUCCESS #################');
        emit(ButtonState(email: 'test@gmail.com', password: 'test@123'));
      } else {
        debugPrint('################### LOGIN FAILED #################');
        emit(ButtonState(email: '', password: ''));
      }
    });
  }
}
