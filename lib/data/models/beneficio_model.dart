import 'package:cloud_firestore/cloud_firestore.dart';

class BeneficioModel {
  final String idBeneficio;
  final String titulo;
  final String dsBeneficio;

  const BeneficioModel({
    required this.idBeneficio,
    required this.titulo,
    required this.dsBeneficio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_beneficio': idBeneficio,
      'titulo': titulo,
      'ds_beneficio': dsBeneficio,
    };
  }

  factory BeneficioModel.fromMap(Map<String, dynamic> map) {
    return BeneficioModel(
      idBeneficio: map['id_beneficio'] ?? '',
      titulo: map['titulo'] ?? '',
      dsBeneficio: map['ds_beneficio'] ?? '',
    );
  }

  factory BeneficioModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    return BeneficioModel(
      idBeneficio: data?['id_beneficio'] ?? doc.id,
      titulo: data?['titulo'] ?? '',
      dsBeneficio: data?['ds_beneficio'] ?? '',
    );
  }

  @override
  String toString() {
    return 'BeneficioModel(idBeneficio: $idBeneficio, titulo: $titulo, dsBeneficio: $dsBeneficio)';
  }
}
