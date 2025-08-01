import 'package:dry_needling/view_model/controllers/homepage/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resourses/app_colors/app_colors.dart';
import '../../resourses/category_card/category_card.dart';
import '../../resourses/components/menue_widget.dart';
import '../../resourses/routes/routes_name.dart';
class HomePage extends StatelessWidget {
  HomePage({super.key}) {
    Get.put(HomePageViewModel()); // Initialize ViewModel
  }

  @override
  Widget build(BuildContext context) {
    final HomePageViewModel viewModel = Get.find<HomePageViewModel>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          "Dry Needling Guide",
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.white),
            onPressed: () => _showSearchDialog(context, viewModel),
          ),
        ],
      ),
      drawer: const MenuWidget(),
      body: Obx(() => viewModel.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(viewModel)),
    );
  }

  Widget _buildContent(HomePageViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Message
          Text(
            "Welcome, Doctor!",
            style: Get.textTheme.headlineSmall!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Select a category to explore procedures:",
            style: Get.textTheme.bodyMedium!.copyWith(
              color: AppColors.black.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 20),

          // Categories Grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                CategoryCard(
                  title: "Upper Limb",
                  icon: Icons.accessibility,
                  color: AppColors.blue,
                  onTap: () => viewModel.navigateToRegion("Upper Limb"),
                ),
                CategoryCard(
                  title: "Lower Limb",
                  icon: Icons.directions_walk,
                  color: AppColors.secondaryColor,
                  onTap: () => viewModel.navigateToRegion("Lower Limb"),
                ),
                CategoryCard(
                  title: "Axial Skeleton",
                  icon: Icons.architecture,
                  color: AppColors.accentColor,
                  onTap: () => viewModel.navigateToRegion("Axial Skeleton"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context, HomePageViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Procedures'),
        content: const TextField(
          decoration: InputDecoration(hintText: 'Search by muscle/region...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              viewModel.navigateToRegion("Search Results");
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}