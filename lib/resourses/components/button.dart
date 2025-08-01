import 'package:flutter/material.dart';
import '../app_colors/app_colors.dart';

class RoundButton extends StatelessWidget {
  RoundButton({
    super.key,
    this.textColor = AppColors.white,
    this.buttonColor = AppColors.primaryColor,
    this.loading = false,
    this.width = 160,
    this.height = 50,
    required this.onPress,
    required this.title,
    this.borderRadius = 12,
  });

  final String title;
  final bool loading;
  final double width, height;
  final Color textColor, buttonColor;
  final VoidCallback onPress;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: loading
            ? Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
          ),
        )
            : Center(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
