import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:areej/services/firebase_auth_implementation/firebase_auth_service.dart';

class SignInState {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  SignInState(
      {required this.isLoading,
      required this.isSuccess,
      this.errorMessage = ''});
}

class SignInStateNotifier extends StateNotifier<SignInState> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  SignInStateNotifier()
      : super(SignInState(isLoading: false, isSuccess: false));

  Future<bool> signIn(String email, String password) async {
    state = SignInState(isLoading: true, isSuccess: false, errorMessage: '');
    try {
      var user = await _authService.signInWithEmailAndPassword(email, password);
      state = SignInState(isLoading: false, isSuccess: user != null);
      return user != null;
    } catch (e) {
      state = SignInState(
          isLoading: false, isSuccess: false, errorMessage: e.toString());
      return false;
    }
  }
}

final signInProvider =
    StateNotifierProvider<SignInStateNotifier, SignInState>((ref) {
  return SignInStateNotifier();
});
