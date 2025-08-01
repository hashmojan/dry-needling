import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../resourses/app_colors/app_colors.dart';
import '../../resourses/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  Future<void> checkUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print("✅ User found, navigating to HomePage");
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/homePage',
            (route) => false,
      );
    } else {
      print("🔒 No user found, navigating to LoginPage");
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/loginPage',
            (route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Future.delayed(Duration(seconds: 3), () {
      checkUser();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
          child: FadeTransition(
            opacity: _fadeIn,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Icon
                Container(
                  width: width * 0.25,
                  height: width * 0.25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Icon(Icons.medical_information, size: 70, color: Colors.white),
                ),
                SizedBox(height: 30),

                // App Name
                Text(
                  'Dry Needling',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 10),

                // Tagline
                Text(
                  'Use the App. Smarter your skills.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 40),

                // Stylish Progress Indicator
                CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
