import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resourses/app_colors/app_colors.dart';
import '../../resourses/routes/routes_name.dart';

class MuscleSelectionPage extends StatelessWidget {
  final String category;
  final String region;

   MuscleSelectionPage({
    super.key,
    required this.category,
    required this.region,
  });

  // Complete muscle data for dry needling
  final Map<String, Map<String, List<String>>> _muscleDatabase = {
    'Lower Limb': {
      'Gluteal': ['Gluteus Maximus', 'Gluteus Medius', 'Gluteus Minimus', 'Piriformis'],
      'Hip': ['Iliopsoas', 'Tensor Fasciae Latae', 'Adductors'],
      'Femoral': ['Quadriceps Femoris', 'Hamstrings', 'Sartorius'],
      'Knee': ['Popliteus', 'Gastrocnemius (Medial/Lateral heads)', 'Plantaris'],
      'Leg': ['Tibialis Anterior', 'Tibialis Posterior', 'Peroneals', 'Soleus'],
      'Talocrural': ['Extensor Digitorum Longus', 'Flexor Hallucis Longus'],
      'Foot': ['Abductor Hallucis', 'Flexor Digitorum Brevis', 'Interossei']
    },
    'Upper Limb': {
      'Shoulder': ['Supraspinatus', 'Infraspinatus', 'Teres Minor', 'Subscapularis'],
      'Arm': ['Biceps Brachii', 'Triceps Brachii', 'Brachialis'],
      'Elbow': ['Brachioradialis', 'Supinator', 'Pronator Teres'],
      'Forearm': ['Extensor Carpi Radialis', 'Flexor Carpi Ulnaris'],
      'Wrist': ['Extensor Pollicis Longus', 'Flexor Digitorum Superficialis'],
      'Hand': ['Thenar Muscles', 'Hypothenar Muscles', 'Lumbricals']
    },
    'Axial Skeleton': {
      'Cervical': ['Sternocleidomastoid', 'Upper Trapezius', 'Levator Scapulae'],
      'Thoracic': ['Rhomboids', 'Middle Trapezius', 'Erector Spinae'],
      'Lumbar': ['Quadratus Lumborum', 'Latissimus Dorsi'],
      'Sacral': ['Multifidus', 'Erector Spinae (Lumbar part)'],
      'Pelvic': ['Pelvic Floor Muscles', 'Obturator Internus']
    }
  };

  @override
  Widget build(BuildContext context) {
    final muscles = _muscleDatabase[category]?[region] ?? [];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          '$category > $region',
          style: const TextStyle(
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
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select a muscle for dry needling procedure:",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.black.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: muscles.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                itemCount: muscles.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return _buildMuscleCard(muscles[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMuscleCard(String muscle) {
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
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.medical_services,
            color: AppColors.primaryColor,
          ),
        ),
        title: Text(
          muscle,
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          'Tap for procedure details',
          style: TextStyle(
            color: AppColors.black.withOpacity(0.5),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.primaryColor,
        ),
        onTap: () => _navigateToProcedureDetail(muscle),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.medical_information,
            size: 60,
            color: AppColors.primaryColor.withOpacity(0.3),
          ),
          const SizedBox(height: 20),
          Text(
            'No muscles found for this region',
            style: TextStyle(
              color: AppColors.black.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Check back for updates',
            style: TextStyle(
              color: AppColors.black.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToProcedureDetail(String muscle) {
    Get.toNamed(
      RouteName.procedureDetail,
      arguments: {
        'category': category,
        'region': region,
        'muscle': muscle,
      },
      // transition: Transition.rightToLeft,
      // duration: const Duration(milliseconds: 300),
    );
  }

  void _showSearchDialog(BuildContext context) {
    final muscles = _muscleDatabase[category]?[region] ?? [];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search Muscles'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: muscles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(muscles[index]),
                  onTap: () {
                    Navigator.pop(context);
                    _navigateToProcedureDetail(muscles[index]);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}