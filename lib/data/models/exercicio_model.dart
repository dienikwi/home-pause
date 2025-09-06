class ExercicioModel {
  final String id;
  final String dsExercicio;
  final String idExercicio;
  final String nmExercicio;
  final String tempoMinutos;
  final String urlVideo;

  const ExercicioModel({
    required this.id,
    required this.dsExercicio,
    required this.idExercicio,
    required this.nmExercicio,
    required this.tempoMinutos,
    required this.urlVideo,
  });

  factory ExercicioModel.fromFirestore(
      Map<String, dynamic> data, String documentId) {
    return ExercicioModel(
      id: documentId,
      dsExercicio: data['ds_exercicio'] as String? ?? '',
      idExercicio: data['id_exercicio'] as String? ?? '',
      nmExercicio: data['nm_exercicio'] as String? ?? '',
      tempoMinutos: data['tempo_minutos'] as String? ?? '',
      urlVideo: data['url_video'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ds_exercicio': dsExercicio,
      'id_exercicio': idExercicio,
      'nm_exercicio': nmExercicio,
      'tempo_minutos': tempoMinutos,
      'url_video': urlVideo,
    };
  }
}
