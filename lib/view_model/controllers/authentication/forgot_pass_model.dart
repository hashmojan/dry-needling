import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassModel {
  final TextEditingController emailController = TextEditingController();

  void dispose() {
    emailController.dispose();
  }

  Future<String?> forgotPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      return "Please enter your email to reset password.";
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null; // No error
    } on FirebaseAuthException catch (ex) {
      return ex.message ?? "An error occurred while resetting password.";
    } catch (e) {
      return "An unexpected error occurred.";
    }
  }
}
