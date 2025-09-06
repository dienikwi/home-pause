import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_pause/core/constants/app_colors.dart';
import 'package:home_pause/core/constants/app_dimensions.dart';
import 'package:home_pause/core/constants/app_text_styles.dart';
import 'package:home_pause/data/models/exercicio_model.dart';
import 'package:home_pause/shared/widgets/custom_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:async';

class ExercicioDetalheView extends StatefulWidget {
  final ExercicioModel exercicio;

  const ExercicioDetalheView({
    super.key,
    required this.exercicio,
  });

  @override
  State<ExercicioDetalheView> createState() => _ExercicioDetalheViewState();
}

class _ExercicioDetalheViewState extends State<ExercicioDetalheView> {
  late YoutubePlayerController _youtubeController;
  Timer? _timer;
  int _seconds = 0;
  int _totalSeconds = 0;
  bool _isTimerRunning = false;
  bool _isTimerFinished = false;

  @override
  void initState() {
    super.initState();
    _initializeYoutubePlayer();
    _initializeTimer();
  }

  void _initializeYoutubePlayer() {
    final videoId = YoutubePlayer.convertUrlToId(
      widget.exercicio.urlVideo,
    );
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  void _initializeTimer() {
    final tempoMinutos = int.tryParse(widget.exercicio.tempoMinutos) ?? 1;
    _totalSeconds = tempoMinutos * 60;
    _seconds = _totalSeconds;
  }

  void _startTimer() {
    if (_isTimerRunning) return;

    setState(() {
      _isTimerRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _isTimerFinished = true;
          _isTimerRunning = false;
          timer.cancel();
        }
      });
    });
  }

  void _pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
      setState(() {
        _isTimerRunning = false;
      });
    }
  }

  void _resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _seconds = _totalSeconds;
      _isTimerRunning = false;
      _isTimerFinished = false;
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _concluirExercicio() {
    // TODO: Implementar marcação como concluído
    // Retorna true indicando que foi concluído
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceWhite,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppDimensions.spacingLarge),

                    // Título do exercício
                    Text(
                      widget.exercicio.nmExercicio,
                      style: GoogleFonts.manrope(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppDimensions.spacingLarge),

                    // Vídeo do YouTube
                    if (widget.exercicio.urlVideo.isNotEmpty)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusMedium,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: YoutubePlayer(
                          controller: _youtubeController,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: AppColors.secondary,
                          progressColors: const ProgressBarColors(
                            playedColor: AppColors.secondary,
                            handleColor: AppColors.secondary,
                          ),
                        ),
                      ),

                    const SizedBox(height: AppDimensions.spacingLarge),

                    // Descrição
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Descrição',
                        style: AppTextStyles.titleSmall,
                      ),
                    ),

                    const SizedBox(height: AppDimensions.spacingSmall),

                    Text(
                      widget.exercicio.dsExercicio,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: AppDimensions.spacingLarge),

                    // Tempo
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tempo',
                        style: AppTextStyles.titleSmall,
                      ),
                    ),

                    const SizedBox(height: AppDimensions.spacingSmall),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${widget.exercicio.tempoMinutos} min',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppDimensions.spacingLarge),

                    // Cronômetro Circular
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Círculo de fundo
                            SizedBox(
                              width: 200,
                              height: 200,
                              child: CircularProgressIndicator(
                                value: 1.0,
                                strokeWidth: 6,
                                backgroundColor:
                                    AppColors.tertiary.withValues(alpha: 0.3),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.tertiary.withValues(alpha: 0.3),
                                ),
                              ),
                            ),

                            // Círculo de progresso
                            SizedBox(
                              width: 200,
                              height: 200,
                              child: CircularProgressIndicator(
                                value: _totalSeconds > 0
                                    ? 1.0 - (_seconds / _totalSeconds)
                                    : 0.0,
                                strokeWidth: 6,
                                backgroundColor: Colors.transparent,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.secondary,
                                ),
                                strokeCap: StrokeCap.round,
                              ),
                            ),

                            // Container central com tempo e controles
                            Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceWhite,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.1),
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Display do tempo
                                  Text(
                                    _formatTime(_seconds),
                                    style: GoogleFonts.manrope(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.secondary,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // Botões do cronômetro
                                  if (!_isTimerFinished) ...[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Botão Play/Pause
                                        IconButton(
                                          onPressed: _isTimerRunning
                                              ? _pauseTimer
                                              : _startTimer,
                                          icon: Icon(
                                            _isTimerRunning
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            size: 20,
                                            color: AppColors.secondary,
                                          ),
                                          style: IconButton.styleFrom(
                                            backgroundColor: AppColors.secondary
                                                .withValues(alpha: 0.1),
                                            padding: const EdgeInsets.all(6),
                                            minimumSize: const Size(32, 32),
                                          ),
                                        ),

                                        const SizedBox(width: 10),

                                        // Botão Reset
                                        IconButton(
                                          onPressed: _resetTimer,
                                          icon: const Icon(
                                            Icons.refresh,
                                            size: 20,
                                            color: AppColors.secondary,
                                          ),
                                          style: IconButton.styleFrom(
                                            backgroundColor: AppColors.secondary
                                                .withValues(alpha: 0.1),
                                            padding: const EdgeInsets.all(6),
                                            minimumSize: const Size(32, 32),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ] else ...[
                                    // Indicador de concluído
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: const BoxDecoration(
                                            color: AppColors.secondary,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: AppColors.textLight,
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Concluído!',
                                          style:
                                              AppTextStyles.bodySmall.copyWith(
                                            color: AppColors.secondary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: AppDimensions.spacingLarge),
                  ],
                ),
              ),
            ),

            // Botão Concluir
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: SizedBox(
                width: double.infinity,
                child: CustomPrimaryButton(
                  text: 'Concluir',
                  onPressed: _isTimerFinished ? _concluirExercicio : null,
                  backgroundColor: _isTimerFinished
                      ? AppColors.secondary
                      : AppColors.tertiary,
                  textColor: AppColors.textLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
