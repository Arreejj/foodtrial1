import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:areej/services/firebase_auth_implementation/firebase_auth_service.dart';

class SignUpState {
  final bool isLoading; // Indicates whether the process is in progress
  final bool isSuccess; // Indicates whether the signup was successful

  SignUpState({required this.isLoading, required this.isSuccess});
}

class SignUpStateNotifier extends StateNotifier<SignUpState> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  SignUpStateNotifier()
      : super(SignUpState(isLoading: false, isSuccess: false));

  /// Sign up for regular users (userType: "user")
  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
    required String mobile,
    required String address,
  }) async {
    state = SignUpState(isLoading: true, isSuccess: false);
    try {
      // Call FirebaseAuthService with all required fields
      var user = await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        role: "user", // Default role
        name: name, // Pass name to FirebaseAuthService
        mobile: mobile, // Pass mobile to FirebaseAuthService
        address: address, // Pass address to FirebaseAuthService
      );
      state = SignUpState(isLoading: false, isSuccess: user != null);
      return user != null;
    } catch (e) {
      state = SignUpState(isLoading: false, isSuccess: false);
      print("Error during sign-up: $e");
      return false;
    }
  }
}

final signUpProvider =
    StateNotifierProvider<SignUpStateNotifier, SignUpState>((ref) {
  return SignUpStateNotifier();
});
