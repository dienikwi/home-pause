import 'package:flutter/material.dart';
import 'package:home_pause/core/constants/app_assets.dart';
import 'package:home_pause/core/constants/app_colors.dart';
import 'package:home_pause/core/constants/app_dimensions.dart';
import 'package:home_pause/core/constants/app_strings.dart';
import 'package:home_pause/core/constants/app_text_styles.dart';
import 'package:home_pause/core/routes/app_routes.dart';
import 'package:home_pause/shared/widgets/custom_card.dart';
import 'package:home_pause/views/components/bottom_nav_bar.dart';

class PrincipalView extends StatelessWidget {
  const PrincipalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDimensions.spacingHuge),
              _buildGreetingSection(),
              const SizedBox(height: AppDimensions.spacingExtraLarge),
              _buildImageSection(),
              const SizedBox(height: AppDimensions.spacingExtraLarge),
              _buildExerciseCard(context),
              const SizedBox(height: AppDimensions.spacingLarge),
              _buildBenefitsCard(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) => _handleBottomNavTap(context, index),
      ),
    );
  }

  Widget _buildGreetingSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.greetingDefault,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: AppDimensions.spacingTiny),
        Text(
          AppStrings.exerciseQuestion,
          style: AppTextStyles.subtitle,
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Center(
      child: Image.asset(
        AppAssets.officeWoman,
        width: AppDimensions.imageExtraLarge,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildExerciseCard(BuildContext context) {
    return CustomCard(
      title: AppStrings.exerciseCardTitle,
      description: AppStrings.exerciseCardDescription,
      backgroundColor: AppColors.primary,
      textColor: AppColors.textLight,
      iconColor: AppColors.textLight,
      onTap: () => _handleExerciseCardTap(context),
    );
  }

  Widget _buildBenefitsCard(BuildContext context) {
    return CustomCard(
      title: AppStrings.benefitsCardTitle,
      description: AppStrings.benefitsCardDescription,
      backgroundColor: AppColors.cardBackground,
      textColor: AppColors.textPrimary,
      iconColor: AppColors.primary,
      onTap: () => _handleBenefitsCardTap(context),
    );
  }

  void _handleExerciseCardTap(BuildContext context) {
    // TODO: Implementar navegação para tela de exercícios
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidade de exercícios em desenvolvimento'),
      ),
    );
  }

  void _handleBenefitsCardTap(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.benefits);
  }

  void _handleBottomNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Já estamos na tela principal
        break;
      case 1:
        // TODO: Implementar navegação para tela de histórico
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Funcionalidade de histórico em desenvolvimento'),
          ),
        );
        break;
      case 2:
        // TODO: Implementar navegação para tela de perfil
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Funcionalidade de perfil em desenvolvimento'),
          ),
        );
        break;
    }
  }
}
