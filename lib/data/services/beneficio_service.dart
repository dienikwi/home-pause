import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_pause/data/models/beneficio_model.dart';

class BeneficioService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const String _collection = 'beneficio';

  void _checkAuth() {
    if (_auth.currentUser == null) {
      throw Exception('Usuário não está autenticado');
    }
  }

  Future<List<BeneficioModel>> getAllBeneficios() async {
    try {
      _checkAuth();

      QuerySnapshot querySnapshot;

      try {
        querySnapshot = await _firestore
            .collection(_collection)
            .orderBy('id_beneficio')
            .get();
      } catch (orderError) {
        querySnapshot = await _firestore.collection(_collection).get();
      }

      final List<BeneficioModel> beneficios = querySnapshot.docs
          .map((doc) => BeneficioModel.fromFirestore(doc))
          .toList();

      beneficios.sort((a, b) => a.idBeneficio.compareTo(b.idBeneficio));

      return beneficios;
    } catch (e) {
      throw Exception('Erro ao carregar benefícios: ${e.toString()}');
    }
  }

  Stream<List<BeneficioModel>> getBeneficiosStream() {
    try {
      _checkAuth();
      return _firestore
          .collection(_collection)
          .orderBy('id_beneficio')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => BeneficioModel.fromFirestore(doc))
              .toList());
    } catch (e) {
      throw Exception('Erro ao obter stream de benefícios: ${e.toString()}');
    }
  }

  Future<BeneficioModel?> getBeneficioById(String id) async {
    try {
      _checkAuth();
      final DocumentSnapshot doc =
          await _firestore.collection(_collection).doc(id).get();

      if (doc.exists) {
        return BeneficioModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Erro ao buscar benefício: ${e.toString()}');
    }
  }
}
