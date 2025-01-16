class User {
  final String name;
  final String email;
  final String mobile;
  final String address;
  final String password;

  User({
    required this.name,
    required this.email,
    required this.mobile,
    required this.address,
    required this.password,
  });

  // Validation for fields
  String? validateName() {
    if (name.isEmpty) {
      return "Please enter your name";
    }
    return null;
  }

  String? validateEmail() {
    String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    if (email.isEmpty) {
      return "Please enter your email";
    }
    if (!regExp.hasMatch(email)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  String? validateMobile() {
    if (mobile.isEmpty) {
      return "Please enter your mobile number";
    }
    if (mobile.length < 10) {
      return "Please enter a valid mobile number";
    }
    return null;
  }

  String? validateAddress() {
    if (address.isEmpty) {
      return "Please enter your address";
    }
    return null;
  }

  String? validatePassword() {
    if (password.isEmpty) {
      return "Please enter your password";
    }
    return null;
  }

  // Method to check if passwords match
  static String? validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return "Please confirm your password";
    }
    if (password != confirmPassword) {
      return "Passwords do not match";
    }
    return null;
  }
}
