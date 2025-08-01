// ✅ login_page.dart (Without GetX, ViewModel logic retained)
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../resourses/app_colors/app_colors.dart';
import '../../resourses/components/button.dart';
import '../../resourses/components/input_field.dart';
import '../../resourses/routes/routes_name.dart';
import '../../view_model/controllers/authentication/login_view_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginVM = LoginViewModel();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    LoginVM.disposeControllers();
    super.dispose();
  }

  void _showSnackBar(String title, String message) {
    final snackBar = SnackBar(
      content: Text('$title: $message'),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _login() async {
    if (_formkey.currentState!.validate()) {
      setState(() => LoginVM.loading = true);
      final result = await LoginVM.loginWithContext(context);
      setState(() => LoginVM.loading = false);
      if (result != null) {
        _showSnackBar('Error', result);
      }
    }
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
                key: _formkey,
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
                        ' Dry Needling Pro',
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
                        'Clinical Education Plateform',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      InputField(
                        controller: LoginVM.emailController,
                        hintText: 'Email Address',
                        prefixIcon: Icon(Icons.email, color: AppColors.primaryColor),
                        keyboardType: TextInputType.emailAddress,
                        fillColor: Colors.white.withOpacity(0.15),
                        errorcolor: Colors.redAccent,
                        paddingBottom: 16,
                        placeholderSize: 15,
                        limit: 50,
                        validator: (value) {
                          if (value == null || value.isEmpty || !value.contains('@')) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      InputField(
                        controller: LoginVM.passwordController,
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
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      RoundButton(
                        title: 'LOGIN',
                        width: double.infinity,
                        buttonColor: AppColors.accentColor,
                        textColor: AppColors.white,
                        onPress: _login,
                        loading: LoginVM.loading,
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgotPasswordPage');
                        },
                        child: Text('Forgot Password?', style: TextStyle(color: Colors.white70)),
                      ),
                      Divider(color: Colors.white24, thickness: 0.5, height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? ", style: TextStyle(color: Colors.white70)),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signupPage');
                            },
                            child: Text(
                              'Sign Up',
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
}
