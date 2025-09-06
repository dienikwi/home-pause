import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_pause/core/constants/app_colors.dart';
import 'package:home_pause/core/constants/app_dimensions.dart';
import 'package:home_pause/core/constants/app_text_styles.dart';
import 'package:home_pause/data/models/exercicio_model.dart';
import 'package:home_pause/data/services/exercicio_service.dart';
import 'package:home_pause/shared/widgets/exercicio_card.dart';
import 'package:home_pause/shared/widgets/custom_button.dart';

class ExerciciosView extends StatefulWidget {
  const ExerciciosView({super.key});

  @override
  State<ExerciciosView> createState() => _ExerciciosViewState();
}

class _ExerciciosViewState extends State<ExerciciosView> {
  final ExercicioService _exercicioService = ExercicioService();
  List<ExercicioModel> _exercicios = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Lista de cores para os círculos dos exercícios
  final List<Color> _circleColors = [
    AppColors.primary,
    AppColors.secondary,
    AppColors.success,
    AppColors.info,
    AppColors.warning,
    const Color(0xFFE91E63), // Rosa
    const Color(0xFF9C27B0), // Roxo
    const Color(0xFF673AB7), // Roxo escuro
    const Color(0xFF3F51B5), // Indigo
    const Color(0xFF009688), // Teal
  ];

  @override
  void initState() {
    super.initState();
    _loadExercicios();
  }

  Future<void> _loadExercicios() async {
    try {
      final exercicios = await _exercicioService.getAllExercicios();
      if (mounted) {
        setState(() {
          _exercicios = exercicios;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year.toString();
    return '$day/$month/$year';
  }

  Color _getCircleColor(int index) {
    return _circleColors[index % _circleColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceWhite,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: Column(
                children: [
                  const SizedBox(height: AppDimensions.spacingLarge),
                  Text(
                    'Exercícios',
                    style: GoogleFonts.manrope(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimensions.spacingSmall),
                  Text(
                    _getCurrentDate(),
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: _buildContent(),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: SizedBox(
                width: double.infinity,
                child: CustomPrimaryButton(
                  text: 'Finalizar',
                  onPressed: () {
                    // TODO: Implementar finalização
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Funcionalidade de finalização em desenvolvimento',
                        ),
                      ),
                    );
                  },
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.textLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.error,
              ),
              const SizedBox(height: AppDimensions.spacingMedium),
              Text(
                'Erro ao carregar exercícios',
                style: AppTextStyles.titleSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spacingSmall),
              Text(
                _errorMessage!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spacingLarge),
              CustomPrimaryButton(
                text: 'Tentar novamente',
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _errorMessage = null;
                  });
                  _loadExercicios();
                },
                backgroundColor: AppColors.primary,
                textColor: AppColors.textLight,
              ),
            ],
          ),
        ),
      );
    }

    if (_exercicios.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.fitness_center,
                size: 64,
                color: AppColors.tertiary,
              ),
              const SizedBox(height: AppDimensions.spacingMedium),
              Text(
                'Nenhum exercício encontrado',
                style: AppTextStyles.titleSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spacingSmall),
              Text(
                'Ainda não há exercícios cadastrados.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
      ),
      itemCount: _exercicios.length,
      itemBuilder: (context, index) {
        final exercicio = _exercicios[index];
        return ExercicioCard(
          exercicio: exercicio,
          circleColor: _getCircleColor(index),
          isConcluido: false, // Por enquanto sempre false
          onTap: () {
            // TODO: Implementar ação do card
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Exercício: ${exercicio.nmExercicio}'),
              ),
            );
          },
        );
      },
    );
  }
}
