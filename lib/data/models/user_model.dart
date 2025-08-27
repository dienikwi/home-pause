import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String nome;
  final DateTime dataAtualizacao;
  final int exerciciosMinutos;
  final int exerciciosDias;

  const UserModel({
    required this.id,
    required this.nome,
    required this.dataAtualizacao,
    required this.exerciciosMinutos,
    required this.exerciciosDias,
  });

  factory UserModel.empty(String id, String nome) {
    return UserModel(
      id: id,
      nome: nome,
      dataAtualizacao: DateTime.now(),
      exerciciosMinutos: 0,
      exerciciosDias: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'data_atualizacao': Timestamp.fromDate(dataAtualizacao),
      'exercicios_minutos': exerciciosMinutos,
      'exercicios_dias': exerciciosDias,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      dataAtualizacao: (map['data_atualizacao'] as Timestamp).toDate(),
      exerciciosMinutos: map['exercicios_minutos'] ?? 0,
      exerciciosDias: map['exercicios_dias'] ?? 0,
    );
  }

  UserModel copyWith({
    String? id,
    String? nome,
    DateTime? dataAtualizacao,
    int? exerciciosMinutos,
    int? exerciciosDias,
  }) {
    return UserModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      dataAtualizacao: dataAtualizacao ?? this.dataAtualizacao,
      exerciciosMinutos: exerciciosMinutos ?? this.exerciciosMinutos,
      exerciciosDias: exerciciosDias ?? this.exerciciosDias,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, nome: $nome, dataAtualizacao: $dataAtualizacao, exerciciosMinutos: $exerciciosMinutos, exerciciosDias: $exerciciosDias)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.nome == nome &&
        other.dataAtualizacao == dataAtualizacao &&
        other.exerciciosMinutos == exerciciosMinutos &&
        other.exerciciosDias == exerciciosDias;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        dataAtualizacao.hashCode ^
        exerciciosMinutos.hashCode ^
        exerciciosDias.hashCode;
  }
}
