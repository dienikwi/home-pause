import 'package:flutter/material.dart';
import 'package:home_pause/core/constants/app_colors.dart';
import 'package:home_pause/core/constants/app_dimensions.dart';
import 'package:home_pause/core/constants/app_text_styles.dart';
import 'package:home_pause/data/models/exercicio_model.dart';

class ExercicioCard extends StatelessWidget {
  final ExercicioModel exercicio;
  final Color circleColor;
  final bool isConcluido;
  final VoidCallback? onTap;

  const ExercicioCard({
    super.key,
    required this.exercicio,
    required this.circleColor,
    this.isConcluido = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingMedium),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          decoration: BoxDecoration(
            color: AppColors.surfaceWhite,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Círculo colorido
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppDimensions.spacingMedium),

              // Título do exercício
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercicio.nmExercicio,
                      style: AppTextStyles.cardTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (exercicio.tempoMinutos.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${exercicio.tempoMinutos} min',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),

              // Ícone de check/status
              Icon(
                Icons.check_rounded,
                color: isConcluido ? AppColors.secondary : AppColors.tertiary,
                size: 30,
                weight: 900,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
