// ✅ signup_view_model.dart (Without GetX)
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../resourses/app_colors/app_colors.dart';
import '../../../services/auth_services/auth_services.dart';
import '../../../resourses/routes/routes_name.dart';

class SignupViewModel {
  final AuthService _authService = AuthService();

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void disposeControllers() {
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  Future<String?> signUpWithContext(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      return "Passwords do not match";
    }

    try {
      String? userId = await _authService.registerUser(
        emailController.text,
        passwordController.text,
      );

      if (userId != null) {
        await saveUserDataToFirestore(userId);


        Navigator.pushNamedAndRemoveUntil(context, '/homePage', (route) => false);
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<void> saveUserDataToFirestore(String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      "userId": userId,
      "name": userNameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }
}
