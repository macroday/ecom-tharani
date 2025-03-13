import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetStartedCubit extends Cubit<GetStartedState> {
  GetStartedCubit() : super(GetStartedState(15.w, false)); // Initial position

  void updatePosition(double dx) {
    final newPosition = (state.position + dx).clamp(15.w, 270.w);
    final isAtEnd = newPosition >= 270.w; // Check if reached the end
    emit(GetStartedState(newPosition, isAtEnd));
  }

  void checkNavigation(Function navigateToHome) {
    if (state.position >= 270.w) {
      navigateToHome(); // Navigate when fully dragged
    } else {
      emit(GetStartedState(15.w, false)); // Reset position and flag
    }
  }
}

class GetStartedState {
  final double position;
  final bool isAtEnd;

  GetStartedState(this.position, this.isAtEnd);
}

class ImageCollageCubit extends Cubit<ScrollController> {
  final double scrollSpeed = 1.0; // Adjust speed
  late Timer _timer;

  ImageCollageCubit() : super(ScrollController()) {
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (state.hasClients) {
        if (state.position.pixels >= state.position.maxScrollExtent - 50) {
          state.jumpTo(0); // Reset to top smoothly
        } else {
          state.animateTo(
            state.offset + scrollSpeed,
            duration: const Duration(milliseconds: 50),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  Future<void> close() {
    _timer.cancel();
    state.dispose();
    return super.close();
  }
}
