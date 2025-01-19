import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Check if an email is already taken
  Future<bool> isEmailTaken(String email) async {
    try {
      final signInMethods = await _auth.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Add a new user to Firestore after sign-up
  Future<void> addUserToFirestore(
    String uid,
    String email,
    String role,
    String name,
    String mobile,
    String address,
  ) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'role': role,
        'name': name,
        'mobile': mobile,
        'address': address,
        'createdAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print("Error adding user to Firestore: $e");
    }
  }

  /// Sign up a new user with email and password
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String role,
    required String name,
    required String mobile,
    required String address,
  }) async {
    try {
      // Sign up the user with email and password
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Now that the user is created, add them to Firestore with all details
      await addUserToFirestore(
        credential.user!.uid,
        email,
        role,
        name,
        mobile,
        address,
      );

      return credential.user;
    } catch (e) {
      print("Error occurred during sign-up: $e");
    }
    return null;
  }

  /// Sign in an existing user with email and password
  Future<Map<String, dynamic>?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Fetch user data from Firestore
      return await getUserData(credential.user!.uid);
    } catch (e) {
      print("Error during sign-in: $e");
    }
    return null;
  }

  /// Fetch user data from Firestore
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final userSnapshot = await _firestore.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        return userSnapshot.data();
      } else {
        print("User not found in Firestore.");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return null;
  }

  /// Redirect user based on userType
  void redirectUserBasedOnType(Map<String, dynamic> userData) {
    String role = userData['role'];

    if (role == 'admin') {
      print("Redirect to Admin Dashboard");
      // Navigate to Admin Dashboard
    } else if (role == 'owner') {
      print("Redirect to Owner Dashboard");
      // Navigate to Owner Dashboard
    } else {
      print("Redirect to User Dashboard");
      // Navigate to User Dashboard
    }
  }

  /// Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Check if the user exists in Firestore
      final userExists = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      // Add user to Firestore if not exists
      if (!userExists.exists) {
        await addUserToFirestore(
          userCredential.user!.uid,
          userCredential.user!.email!,
          'user', // Default type for Google sign-in
          '',
          '',
          '',
        );
      }

      return userCredential.user;
    } catch (e) {
      print("Error during Google sign-in: $e");
    }
    return null;
  }

  /// Logout the user
  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
