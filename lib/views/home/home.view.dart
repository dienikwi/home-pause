import 'package:flutter/material.dart';
import 'package:home_pause/core/constants/app_assets.dart';
import 'package:home_pause/core/constants/app_dimensions.dart';
import 'package:home_pause/core/constants/app_strings.dart';
import 'package:home_pause/core/constants/app_text_styles.dart';
import 'package:home_pause/core/routes/app_routes.dart';
import 'package:home_pause/shared/widgets/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildWelcomeSection(),
                const SizedBox(height: AppDimensions.spacingHuge),
                _buildImageSection(),
                const SizedBox(height: AppDimensions.spacingHuge),
                _buildActionSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppStrings.welcomeTitle,
          style: AppTextStyles.titleLarge,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppDimensions.spacingSmall),
        Text(
          AppStrings.welcomeSubtitle,
          style: AppTextStyles.subtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Image.asset(
      AppAssets.welcomeWoman,
      width: AppDimensions.imageLarge,
      fit: BoxFit.contain,
    );
  }

  Widget _buildActionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          AppStrings.chooseOptionDescription,
          style: AppTextStyles.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.spacingLarge),
        CustomPrimaryButton(
          text: AppStrings.loginButton,
          onPressed: () => _navigateToLogin(context),
        ),
        const SizedBox(height: AppDimensions.spacingMedium),
        CustomSecondaryButton(
          text: AppStrings.registerButton,
          onPressed: () => _navigateToRegister(context),
        ),
      ],
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.login);
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.register);
  }
}
