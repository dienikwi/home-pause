import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_pause/data/models/user_model.dart';
import 'package:home_pause/core/utils/utils.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserModel?> createAccount({
    required String email,
    required String password,
    required String nome,
  }) async {
    UserCredential? credential;
    String? userId;

    try {
      print('🚀 Iniciando criação de conta para: $email');

      credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('✅ Credential criado com sucesso');

      if (credential.user == null) {
        print('❌ User é null no credential');
        throw Exception('Erro ao criar usuário - user é null');
      }

      userId = credential.user!.uid;
      print('✅ Usuário criado no Auth com UID: $userId');

      final nomeFormatado = nome.capitalizeWords;

      await Future.delayed(const Duration(milliseconds: 1000));

      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null || currentUser.uid != userId) {
        print(
            '⚠️ Usuário atual não corresponde ao criado. Tentando recarregar...');
        await _firebaseAuth.currentUser?.reload();
      }

      final userModel = UserModel.empty(userId, nomeFormatado);

      print('📝 Dados do usuário a serem salvos: ${userModel.toMap()}');

      int tentativas = 0;
      const maxTentativas = 3;
      bool salvouComSucesso = false;

      while (tentativas < maxTentativas && !salvouComSucesso) {
        try {
          tentativas++;
          print('💾 Tentativa $tentativas de salvar no Firestore...');

          await _firestore
              .collection('usuarios')
              .doc(userId)
              .set(userModel.toMap(), SetOptions(merge: true));

          await Future.delayed(const Duration(milliseconds: 500));
          final doc = await _firestore.collection('usuarios').doc(userId).get();

          if (doc.exists && doc.data() != null) {
            print('✅ Dados salvos e verificados no Firestore!');
            print('📄 Dados salvos: ${doc.data()}');
            salvouComSucesso = true;
          } else {
            print('⚠️ Documento não foi encontrado após salvamento');
            if (tentativas < maxTentativas) {
              await Future.delayed(Duration(milliseconds: 500 * tentativas));
            }
          }
        } catch (firestoreError) {
          print(
              '❌ Erro ao salvar no Firestore (tentativa $tentativas): $firestoreError');
          if (tentativas >= maxTentativas) {
            rethrow;
          }
          await Future.delayed(Duration(milliseconds: 500 * tentativas));
        }
      }

      if (!salvouComSucesso) {
        throw Exception(
            'Não foi possível salvar os dados no Firestore após $maxTentativas tentativas');
      }

      return userModel;
    } on FirebaseAuthException catch (e) {
      print('❌ Erro do Firebase Auth: ${e.code} - ${e.message}');
      if (credential?.user != null) {
        try {
          await credential!.user!.delete();
          print('�️ Usuário removido do Auth devido ao erro');
        } catch (deleteError) {
          print('⚠️ Não foi possível remover usuário do Auth: $deleteError');
        }
      }
      throw _handleAuthException(e);
    } catch (e, stackTrace) {
      print('❌ Erro inesperado: $e');
      print('📄 StackTrace: $stackTrace');

      if (credential?.user != null) {
        try {
          await credential!.user!.delete();
          print('🗑️ Usuário removido do Auth devido ao erro inesperado');
        } catch (deleteError) {
          print('⚠️ Não foi possível remover usuário do Auth: $deleteError');
        }
      }

      throw Exception('Erro inesperado ao criar conta: ${e.toString()}');
    }
  }

  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = credential.user;
      if (user == null) throw Exception('Erro ao fazer login');

      final userDoc =
          await _firestore.collection('usuarios').doc(user.uid).get();

      if (!userDoc.exists) {
        throw Exception('Dados do usuário não encontrados');
      }

      return UserModel.fromMap(userDoc.data()!);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Erro inesperado ao fazer login: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Erro ao fazer logout: ${e.toString()}');
    }
  }

  Future<UserModel?> getCurrentUserData() async {
    try {
      final User? user = currentUser;
      if (user == null) return null;

      final userDoc =
          await _firestore.collection('usuarios').doc(user.uid).get();

      if (!userDoc.exists) return null;

      return UserModel.fromMap(userDoc.data()!);
    } catch (e) {
      throw Exception('Erro ao buscar dados do usuário: ${e.toString()}');
    }
  }

  Future<void> updateUserData(UserModel userModel) async {
    try {
      final User? user = currentUser;
      if (user == null) throw Exception('Usuário não está logado');

      final updatedModel = userModel.copyWith(
        nome: userModel.nome.capitalizeWords,
        dataAtualizacao: DateTime.now(),
      );

      await _firestore
          .collection('usuarios')
          .doc(user.uid)
          .update(updatedModel.toMap());
    } catch (e) {
      throw Exception('Erro ao atualizar dados do usuário: ${e.toString()}');
    }
  }

  Future<void> updateUserName(String newName) async {
    try {
      final User? user = currentUser;
      if (user == null) throw Exception('Usuário não está logado');

      final nomeFormatado = newName.capitalizeWords;

      await _firestore.collection('usuarios').doc(user.uid).update({
        'nome': nomeFormatado,
        'dataAtualizacao': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Erro ao atualizar nome do usuário: ${e.toString()}');
    }
  }

  Future<void> deleteAccount() async {
    try {
      final User? user = currentUser;
      if (user == null) throw Exception('Usuário não está logado');

      // Primeiro, deletar os dados do Firestore
      await _firestore.collection('usuarios').doc(user.uid).delete();

      // Depois, deletar a conta do Firebase Auth
      await user.delete();
    } catch (e) {
      throw Exception('Erro ao excluir conta: ${e.toString()}');
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'A senha é muito fraca.';
      case 'email-already-in-use':
        return 'Este email já está sendo usado por outra conta.';
      case 'invalid-email':
        return 'O email fornecido é inválido.';
      case 'user-not-found':
        return 'Usuário não encontrado.';
      case 'wrong-password':
        return 'Senha incorreta.';
      case 'user-disabled':
        return 'Esta conta foi desabilitada.';
      case 'too-many-requests':
        return 'Muitas tentativas de login. Tente novamente mais tarde.';
      case 'operation-not-allowed':
        return 'Login com email e senha não está habilitado.';
      case 'invalid-credential':
        return 'As credenciais fornecidas são inválidas.';
      default:
        return 'Erro de autenticação: ${e.message}';
    }
  }
}
