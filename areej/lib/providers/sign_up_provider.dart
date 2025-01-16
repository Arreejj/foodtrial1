import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:areej/user_auth/firebase_auth_implementation/firebase_auth_service.dart';

class SignUpState {
  final bool isLoading; //to check if it's in progress 
  final bool isSuccess;

  SignUpState({required this.isLoading, required this.isSuccess});
}

class SignUpStateNotifier extends StateNotifier<SignUpState> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  SignUpStateNotifier() : super(SignUpState(isLoading: false, isSuccess: false));

  Future<bool> signUp(String email, String password) async {
    state = SignUpState(isLoading: true, isSuccess: false);
    try {
      var user = await _authService.signUpWithEmailAndPassword(email, password);
      state = SignUpState(isLoading: false, isSuccess: user != null);
      return user != null;
    } catch (e) {
      state = SignUpState(isLoading: false, isSuccess: false);
      return false;
    }
  }
}

final signUpProvider = StateNotifierProvider<SignUpStateNotifier, SignUpState>((ref) {
  return SignUpStateNotifier();
});
