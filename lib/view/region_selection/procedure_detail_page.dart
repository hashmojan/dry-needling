import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resourses/app_colors/app_colors.dart';
import '../../resourses/components/button.dart';

class ProcedureDetailPage extends StatelessWidget {
  final String category;
  final String region;
  final String muscle;

   ProcedureDetailPage({
    super.key,
    required this.category,
    required this.region,
    required this.muscle,
  });

  // Complete dry needling procedure database
  final Map<String, Map<String, String>> procedureData = {
    // Lower Limb Muscles
    'Gastrocnemius': {
      'description': 'Superficial two-headed calf muscle responsible for plantar flexion. Common site for trigger points causing calf pain.',
      'procedure': '1. Patient Position: Prone with ankle dorsiflexed\n'
          '2. Locate trigger points in medial/lateral bellies\n'
          '3. Insert 0.25mm needle at 30° angle\n'
          '4. Use pistoning technique for 10-15 seconds\n'
          '5. Apply post-needling stretching',
      'precautions': '• Avoid posterior tibial neurovascular bundle\n'
          '• Watch for excessive bleeding in superficial portion\n'
          '• Post-treatment soreness common for 24-48 hours',
      'image': 'assets/images/gastrocnemius.png',
    },
    'Quadriceps Femoris': {
      'description': 'Large thigh muscle group often affected in patellofemoral pain syndrome. Needling helps relieve anterior knee pain.',
      'procedure': '1. Patient Position: Supine with knee extended\n'
          '2. Palpate for taut bands in rectus femoris/vastus muscles\n'
          '3. Insert needle perpendicular to skin\n'
          '4. Apply local twitch responses 2-3 times per site\n'
          '5. Follow with active ROM exercises',
      'precautions': '• Avoid femoral artery in proximal thigh\n'
          '• Caution with patients on blood thinners\n'
          '• May cause temporary muscle soreness',
      'image': 'assets/images/quadriceps.png',
    },
    'Gluteus Medius': {
      'description': 'Primary hip abductor often involved in lateral hip pain and IT band syndrome. Common in runners and athletes.',
      'procedure': '1. Patient Position: Side-lying with affected side up\n'
          '2. Locate trigger points posterior to iliac crest\n'
          '3. Insert needle at 45° angle toward pelvis\n'
          '4. Use 5-6 fast in-and-out movements\n'
          '5. Apply pressure post-treatment',
      'precautions': '• Avoid sciatic nerve in deep needle placement\n'
          '• Use shorter needles for thin patients\n'
          '• May cause temporary weakness',
      'image': 'assets/images/ello.png',
    },

    // Upper Limb Muscles
    'Supraspinatus': {
      'description': 'First rotator cuff muscle, commonly involved in shoulder impingement and tendinopathy.',
      'procedure': '1. Patient Position: Prone with arm hanging\n'
          '2. Locate muscle in supraspinous fossa\n'
          '3. Insert needle laterally toward acromion\n'
          '4. Use 2-3 needle passes per trigger point\n'
          '5. Follow with pendulum exercises',
      'precautions': '• Avoid lung apex with deep penetration\n'
          '• Use caution with osteoporotic patients\n'
          '• Post-needling soreness common',
      'image': 'assets/images/supraspinatus.png',
    },

    // Axial Skeleton Muscles
    'Upper Trapezius': {
      'description': 'Common site for tension headaches and neck pain. Frequently overactive in desk workers.',
      'procedure': '1. Patient Position: Seated with head supported\n'
          '2. Palpate for taut bands near shoulder\n'
          '3. Insert needle superficially (5-10mm depth)\n'
          '4. Use 3-4 quick needle motions\n'
          '5. Apply moist heat post-treatment',
      'precautions': '• Avoid carotid artery and cervical spine\n'
          '• Watch for vasovagal reactions\n'
          '• Use minimal needle depth',
      'image': 'assets/images/trapezius.png',
    },
  };

  @override
  Widget build(BuildContext context) {
    final data = procedureData[muscle] ?? {
      'description': 'Dry needling procedure documentation for $muscle is currently under development.',
      'procedure': 'Check back soon for detailed procedure steps.\n\n'
          'General dry needling principles apply:\n'
          '1. Identify trigger points\n'
          '2. Cleanse skin area\n'
          '3. Use sterile filiform needles\n'
          '4. Elicit local twitch responses\n'
          '5. Post-needling care',
      'precautions': '• Standard universal precautions apply\n'
          '• Avoid neurovascular structures\n'
          '• Monitor for adverse reactions',
      'image': '',
    };

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          '$muscle Needling',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Anatomical Image
            if (data['image']!.isNotEmpty)
              Hero(
                tag: 'muscle-image-$muscle',
                child: Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.secondaryColor.withOpacity(0.1),
                  ),
                  child: Image.asset(
                    data['image']!,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            else
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.secondaryColor.withOpacity(0.1),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.medical_services,
                      size: 50,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Anatomical Illustration',
                      style: TextStyle(
                        color: AppColors.primaryColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),

            // Muscle Description
            _buildSectionHeader('Anatomical Description'),
            const SizedBox(height: 8),
            Text(
              data['description']!,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.black.withOpacity(0.8),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),

            // Procedure Steps
            _buildSectionHeader('Dry Needling Protocol'),
            const SizedBox(height: 8),
            Text(
              data['procedure']!,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.black,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),

            // Precautions
            _buildSectionHeader('Clinical Precautions', isWarning: true),
            const SizedBox(height: 8),
            Text(
              data['precautions']!,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.dangerColor.withOpacity(0.9),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 30),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundButton(
                  title: "Save Protocol",
                  onPress: () => _saveProcedure(),
                  width: 150,
                ),
                RoundButton(
                  title: "Video Demo",
                  onPress: () => _showVideoDemo(),
                  buttonColor: AppColors.secondaryColor,
                  width: 150,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool isWarning = false}) {
    return Row(
      children: [
        Icon(
          isWarning ? Icons.warning : Icons.medical_information,
          color: isWarning ? AppColors.dangerColor : AppColors.primaryColor,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isWarning ? AppColors.dangerColor : AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  void _saveProcedure() {
    Get.snackbar(
      'Protocol Saved',
      '$muscle dry needling added to your favorites',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      colorText: AppColors.white,
      duration: const Duration(seconds: 2),
    );
    // TODO: Implement actual save functionality
  }

  void _showVideoDemo() {
    Get.defaultDialog(
      title: 'Video Demonstration',
      content: Column(
        children: [
          const Icon(Icons.video_library, size: 50, color: AppColors.primaryColor),
          const SizedBox(height: 10),
          Text(
            'Professional dry needling technique for $muscle',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      textConfirm: 'Watch',
      onConfirm: () {
        Get.back();
        // TODO: Launch video player
      },
    );
  }
}