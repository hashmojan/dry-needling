import 'package:get/get.dart';

import '../../../resourses/routes/routes_name.dart';

class HomePageViewModel extends GetxController {
  // For future state management
  final RxBool isLoading = false.obs;

  // Navigation handler
  void navigateToRegion(String category) {
    Get.toNamed(
      RouteName.regionSelection,
      arguments: category,
    );
  }

  // Future expansion: User data, notifications, etc.
  Future<void> loadUserData() async {
    isLoading(true);
    // Add your data loading logic here
    await Future.delayed(const Duration(seconds: 1));
    isLoading(false);
  }

  @override
  void onInit() {
    loadUserData();
    super.onInit();
  }
}