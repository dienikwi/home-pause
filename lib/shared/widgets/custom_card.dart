import 'package:flutter/material.dart';
import 'package:home_pause/core/constants/app_colors.dart';
import 'package:home_pause/core/constants/app_dimensions.dart';
import 'package:home_pause/core/constants/app_text_styles.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String description;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool showIcon;

  const CustomCard({
    super.key,
    required this.title,
    required this.description,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.icon,
    this.onTap,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final cardBackgroundColor = backgroundColor ?? AppColors.cardBackground;
    final cardTextColor = textColor ?? AppColors.textPrimary;
    final cardIconColor = iconColor ?? AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusExtraLarge),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: AppDimensions.elevationLow,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.cardTitle.copyWith(
                      color: cardTextColor,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingMedium),
                  Text(
                    description,
                    style: AppTextStyles.cardDescription.copyWith(
                      color: cardTextColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (showIcon) ...[
              const SizedBox(width: AppDimensions.spacingMedium),
              Icon(
                icon ?? Icons.arrow_circle_right,
                color: cardIconColor,
                size: AppDimensions.iconExtraLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
