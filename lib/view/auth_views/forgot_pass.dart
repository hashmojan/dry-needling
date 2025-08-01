import 'package:flutter/material.dart';
import '../../resourses/app_colors/app_colors.dart';
import '../../resourses/components/button.dart';
import '../../resourses/components/input_field.dart';
import '../../resourses/routes/routes_name.dart';
import '../../view_model/controllers/authentication/forgot_pass_model.dart';
import '../../utils/utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final ForgotPassModel forgotPassVM = ForgotPassModel();
  bool isLoading = false;

  void _handleForgotPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      final error = await forgotPassVM.forgotPassword();

      if (error != null) {
        Utils.snackBar(context,"Error", error);
      } else {
        Utils.snackBar(context,"Success", "Password reset email has been sent.");
      }

      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    forgotPassVM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_reset, size: 70, color: Colors.white),
                      SizedBox(height: 20),
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Enter your email and we\'ll send you a reset link.',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),

                      // Email field
                      InputField(
                        controller: forgotPassVM.emailController,
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email, color: AppColors.primaryColor),
                        keyboardType: TextInputType.emailAddress,
                        fillColor: Colors.white.withOpacity(0.15),
                        errorcolor: Colors.redAccent,
                        paddingBottom: 16,
                        placeholderSize: 15,
                        limit: 50,
                        validator: (String? value) {
                          if (value == null || value.isEmpty || !value.contains('@')) {
                            return 'Invalid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),

                      // Send button
                      RoundButton(
                        title: 'SEND RESET LINK',
                        width: double.infinity,
                        buttonColor: AppColors.accentColor,
                        textColor: Colors.white,
                        onPress: _handleForgotPassword,
                        loading: isLoading,
                      ),
                      SizedBox(height: 20),

                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/loginpage');
                        },
                        child: Text(
                          'Back to Login',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
