import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_pause/core/constants/app_assets.dart';
import 'package:home_pause/core/constants/app_colors.dart';
import 'package:home_pause/core/constants/app_dimensions.dart';
import 'package:home_pause/core/constants/app_strings.dart';
import 'package:home_pause/core/constants/app_text_styles.dart';
import 'package:home_pause/core/routes/app_routes.dart';
import 'package:home_pause/data/models/user_model.dart';
import 'package:home_pause/data/services/auth_service.dart';
import 'package:home_pause/shared/widgets/custom_card.dart';
import 'package:home_pause/views/components/bottom_nav_bar.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  final _authService = AuthService();
  UserModel? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await _authService.getCurrentUserData();
      if (mounted) {
        setState(() {
          _currentUser = user;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar dados: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.surfaceWhite,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
    final userName = _currentUser?.nome ?? 'Usuário';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Olá, $userName',
          style: GoogleFonts.manrope(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingTiny),
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
    Navigator.pushNamed(context, AppRoutes.exercises);
  }

  void _handleBenefitsCardTap(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.benefits);
  }

  void _handleBottomNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
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
        Navigator.pushNamed(context, AppRoutes.profile);
        break;
    }
  }
}
