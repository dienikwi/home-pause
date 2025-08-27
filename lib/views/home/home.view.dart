import 'package:flutter/material.dart';
import 'package:home_pause/core/constants/app_assets.dart';
import 'package:home_pause/core/constants/app_dimensions.dart';
import 'package:home_pause/core/constants/app_strings.dart';
import 'package:home_pause/core/constants/app_text_styles.dart';
import 'package:home_pause/core/routes/app_routes.dart';
import 'package:home_pause/data/services/session_service.dart';
import 'package:home_pause/shared/widgets/custom_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkUserSession();
  }

  Future<void> _checkUserSession() async {
    try {
      final isLoggedIn = await SessionService.isUserLoggedIn();
      if (mounted) {
        if (isLoggedIn) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.main);
        } else {
          setState(() {
            _isChecking = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isChecking = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppStrings.welcomeTitle,
          style: AppTextStyles.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.spacingSmall),
        Text(
          AppStrings.welcomeSubtitle,
          style: AppTextStyles.subtitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.spacingMedium),
        Text(
          AppStrings.chooseOptionDescription,
          style: AppTextStyles.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Center(
      child: Image.asset(
        AppAssets.welcomeWoman,
        width: AppDimensions.imageExtraLarge,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildActionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomPrimaryButton(
          text: AppStrings.loginButton,
          onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
        ),
        const SizedBox(height: AppDimensions.spacingMedium),
        CustomSecondaryButton(
          text: AppStrings.registerButton,
          onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
        ),
      ],
    );
  }
}
