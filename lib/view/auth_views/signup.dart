// ✅ signup_page.dart (Without GetX)
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../resourses/app_colors/app_colors.dart';
import '../../resourses/components/button.dart';
import '../../resourses/components/input_field.dart';
import '../../resourses/routes/routes_name.dart';
import '../../view_model/controllers/authentication/signup_view_model.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final SignupVM = SignupViewModel();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

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
                      Icon(MdiIcons.needle, size: 70, color: Colors.white),
                      SizedBox(height: 20),
                      Text(
                        'Create Your Account',
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
                        'Make yourself Master in Needling',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      InputField(
                        controller: SignupVM.userNameController,
                        hintText: 'Full Name',
                        prefixIcon: Icon(Icons.person, color: AppColors.primaryColor),
                        keyboardType: TextInputType.name,
                        fillColor: Colors.white.withOpacity(0.15),
                        errorcolor: Colors.redAccent,
                        paddingBottom: 16,
                        placeholderSize: 15,
                        limit: 50,
                        validator: (value) =>
                        value == null || value.trim().isEmpty ? 'Enter your full name' : null,
                      ),
                      SizedBox(height: 16),
                      InputField(
                        controller: SignupVM.emailController,
                        hintText: 'Email Address',
                        prefixIcon: Icon(Icons.email, color: AppColors.primaryColor),
                        keyboardType: TextInputType.emailAddress,
                        fillColor: Colors.white.withOpacity(0.15),
                        errorcolor: Colors.redAccent,
                        paddingBottom: 16,
                        placeholderSize: 15,
                        limit: 50,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty || !value.contains('@')) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      InputField(
                        controller: SignupVM.phoneController,
                        hintText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone, color: AppColors.primaryColor),
                        keyboardType: TextInputType.phone,
                        fillColor: Colors.white.withOpacity(0.15),
                        errorcolor: Colors.redAccent,
                        paddingBottom: 16,
                        placeholderSize: 15,
                        limit: 15,
                        validator: (value) =>
                        value == null || value.trim().isEmpty ? 'Enter your phone number' : null,
                      ),
                      SizedBox(height: 16),
                      InputField(
                        controller: SignupVM.passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        prefixIcon: Icon(Icons.lock, color: AppColors.primaryColor),
                        fillColor: Colors.white.withOpacity(0.15),
                        errorcolor: Colors.redAccent,
                        paddingBottom: 16,
                        placeholderSize: 15,
                        limit: 50,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      InputField(
                        controller: SignupVM.confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: true,
                        prefixIcon: Icon(Icons.lock_outline, color: AppColors.primaryColor),
                        fillColor: Colors.white.withOpacity(0.15),
                        errorcolor: Colors.redAccent,
                        paddingBottom: 16,
                        placeholderSize: 15,
                        limit: 50,
                        validator: (value) {
                          if (value != SignupVM.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      RoundButton(
                        title: 'SIGN UP',
                        width: double.infinity,
                        buttonColor: AppColors.accentColor,
                        textColor: AppColors.white,
                        onPress: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            final error = await SignupVM.signUpWithContext(context);
                            if (error != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error), backgroundColor: Colors.red),
                              );
                            }
                            setState(() => loading = false);
                          }
                        },
                        loading: loading,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? ", style: TextStyle(color: Colors.white70)),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, '/loginPage'),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )
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

  @override
  void dispose() {
    SignupVM.disposeControllers();
    super.dispose();
  }
}
