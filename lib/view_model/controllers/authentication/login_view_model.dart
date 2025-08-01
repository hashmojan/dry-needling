// ✅ login_view_model.dart (Without GetX)
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../resourses/routes/routes_name.dart';
import '../../../utils/utils.dart';

class LoginViewModel {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  bool loading = false;

  Future<String?> loginWithContext(BuildContext context) async {
    try {
      // Validate fields
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        // Utils.snackBar('Enter Required Fields', 'Please fill in all the required fields.', context);
        return null;
      }

      // Sign in with Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Clear controllers
      emailController.clear();
      passwordController.clear();

      // Navigate to home page
      Navigator.pushNamedAndRemoveUntil(context, '/homePage', (route) => false);

      return null; // No error
    } on FirebaseAuthException catch (ex) {
      return _getErrorMessage(ex.code);
    } catch (_) {
      return 'An unexpected error occurred';
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-email':
        return 'Invalid email address';
      default:
        return 'Login failed. Please try again';
    }
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }
}
