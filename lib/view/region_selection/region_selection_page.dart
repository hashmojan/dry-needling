import 'package:flutter/material.dart';
import '../../resourses/app_colors/app_colors.dart';

class RegionSelectionPage extends StatelessWidget {
  final String category;

   RegionSelectionPage({
    super.key,
    required this.category,
  });

  // Define regions for each category
  final Map<String, List<String>> _categoryRegions = {
    'Upper Limb': ['Shoulder', 'Arm', 'Elbow', 'Forearm', 'Wrist', 'Hand'],
    'Lower Limb': ['Gluteal', 'Hip', 'Femoral', 'Knee', 'Leg', 'Talocrural', 'Foot'],
    'Axial Skeleton': ['Cervical', 'Thoracic', 'Lumbar', 'Sacral', 'Pelvic'],
  };

  @override
  Widget build(BuildContext context) {
    final regions = _categoryRegions[category] ?? [];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          category,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select a region:",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.black.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: regions.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return _buildRegionCard(context, regions[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegionCard(BuildContext context, String region) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        title: Text(
          region,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.primaryColor,
        ),
        onTap: () => _navigateToMusclePage(context, region),
      ),
    );
  }

  void _navigateToMusclePage(BuildContext context, String region) {
    Navigator.pushNamed(
      context,
      '/muscleSelection',
      arguments: {
        'category': category,
        'region': region,
      },
    );
  }

}