import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CheckOutEvent extends Equatable {
  const CheckOutEvent();
  @override
  List<Object> get props => [];
}

class ChoosePaymentMode extends CheckOutEvent {
  final int paymentOption;
  const ChoosePaymentMode({required this.paymentOption});
  @override
  List<Object> get props => [paymentOption];
}

abstract class CheckOutState extends Equatable {
  const CheckOutState();
  @override
  List<Object> get props => [];
}

class PaymentState extends CheckOutState {
  final String paymentMode;
  final int paymentOption;
  const PaymentState({required this.paymentMode, required this.paymentOption});
  @override
  List<Object> get props => [paymentMode, paymentOption];
}

class PaymentBloc extends Bloc<CheckOutEvent, PaymentState> {
  PaymentBloc()
      : super(const PaymentState(paymentMode: '', paymentOption: -1)) {
    on<ChoosePaymentMode>((event, emit) {
      switch (event.paymentOption) {
        case 0:
          emit(PaymentState(
              paymentMode: 'GPay', paymentOption: event.paymentOption));
          break;
        case 1:
          emit(PaymentState(
              paymentMode: 'Debit Card', paymentOption: event.paymentOption));
          break;
        case 2:
          emit(PaymentState(
              paymentMode: 'UPI ID', paymentOption: event.paymentOption));
      }
    });
  }
}
