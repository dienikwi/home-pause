import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_pause/data/models/exercicio_model.dart';

class ExercicioService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Busca todos os exercícios da coleção 'exercicio'
  Future<List<ExercicioModel>> getAllExercicios() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection('exercicio').get();

      return querySnapshot.docs
          .map((doc) => ExercicioModel.fromFirestore(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ))
          .toList();
    } catch (e) {
      throw Exception('Erro ao buscar exercícios: $e');
    }
  }

  /// Busca um exercício específico por ID
  Future<ExercicioModel?> getExercicioById(String id) async {
    try {
      final DocumentSnapshot doc =
          await _firestore.collection('exercicio').doc(id).get();

      if (doc.exists) {
        return ExercicioModel.fromFirestore(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }
      return null;
    } catch (e) {
      throw Exception('Erro ao buscar exercício: $e');
    }
  }
}
