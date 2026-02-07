import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliment_response.dart';
import '../services/api_service.dart';

// State for compliments
class ComplimentState {
  final bool isLoading;
  final ComplimentResponse? response;
  final String? error;

  ComplimentState({
    this.isLoading = false,
    this.response,
    this.error,
  });

  ComplimentState copyWith({
    bool? isLoading,
    ComplimentResponse? response,
    String? error,
  }) {
    return ComplimentState(
      isLoading: isLoading ?? this.isLoading,
      response: response ?? this.response,
      error: error ?? this.error,
    );
  }
}

// Compliment Notifier
class ComplimentNotifier extends StateNotifier<ComplimentState> {
  ComplimentNotifier() : super(ComplimentState());

  /// Fetch compliments from API
  Future<void> fetchCompliments(File imageFile) async {
    // Set loading state
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Call API
      final response = await ApiService.getCompliments(imageFile);

      // Update state with response
      state = state.copyWith(
        isLoading: false,
        response: response,
        error: null,
      );
    } catch (e) {
      // Update state with error
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Reset state
  void reset() {
    state = ComplimentState();
  }
}

// Provider
final complimentProvider =
    StateNotifierProvider<ComplimentNotifier, ComplimentState>(
  (ref) => ComplimentNotifier(),
);
