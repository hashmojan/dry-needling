import 'package:dry_needling/resourses/routes/routes_name.dart';
import 'package:dry_needling/view/region_selection/muscle_selection_page.dart';
import 'package:dry_needling/view/region_selection/procedure_detail_page.dart';
import 'package:dry_needling/view/region_selection/region_selection_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

// Auth Views
import '../../view/auth_views/forgot_pass.dart';
import '../../view/auth_views/login.dart';
import '../../view/auth_views/signup.dart';
import '../../view/splash/splash_screen.dart';

// Main App Views
import '../../view/home_page/home_page.dart';

class AppRoutes {
  static final List<GetPage> routes = [
    // Auth Routes
    GetPage(name: RouteName.splashScreen, page: () =>  SplashScreen()),
    GetPage(name: RouteName.loginPage, page: () =>  LoginPage()),
    GetPage(name: RouteName.signupPage, page: () =>  SignupPage()),
    GetPage(name: RouteName.forgotPasswordPage, page: () =>  ForgotPasswordPage()),

    // Main App Routes
    GetPage(name: RouteName.homePage, page: () =>  HomePage()),

    GetPage(
      name: RouteName.regionSelection,
      page: () => RegionSelectionPage(
        category: Get.arguments as String,
      ),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: RouteName.muscleSelection,
      page: () => MuscleSelectionPage(
        category: Get.arguments['category'],
        region: Get.arguments['region'],
      ),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: RouteName.procedureDetail,
      page: () => ProcedureDetailPage(
        category: Get.arguments['category'],
        region: Get.arguments['region'],
        muscle: Get.arguments['muscle'],
      ),
      transition: Transition.rightToLeft,
    ),

  ];
}