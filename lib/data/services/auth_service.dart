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
      credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Erro ao criar usuário - user é null');
      }

      userId = credential.user!.uid;

      final nomeFormatado = nome.capitalizeWords;

      await Future.delayed(const Duration(milliseconds: 1000));

      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null || currentUser.uid != userId) {
        await _firebaseAuth.currentUser?.reload();
      }

      final userModel = UserModel.empty(userId, nomeFormatado);

      int tentativas = 0;
      const maxTentativas = 3;
      bool salvouComSucesso = false;

      while (tentativas < maxTentativas && !salvouComSucesso) {
        try {
          tentativas++;

          await _firestore
              .collection('usuarios')
              .doc(userId)
              .set(userModel.toMap(), SetOptions(merge: true));

          await Future.delayed(const Duration(milliseconds: 500));
          final doc = await _firestore.collection('usuarios').doc(userId).get();

          if (doc.exists && doc.data() != null) {
            salvouComSucesso = true;
          } else {
            if (tentativas < maxTentativas) {
              await Future.delayed(Duration(milliseconds: 500 * tentativas));
            }
          }
        } catch (firestoreError) {
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
      if (credential?.user != null) {
        await credential!.user!.delete();
      }

      throw _handleAuthException(e);
    } catch (e) {
      if (credential?.user != null) {
        await credential!.user!.delete();
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
        'data_atualizacao': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Erro ao atualizar nome do usuário: ${e.toString()}');
    }
  }

  Future<void> deleteAccount() async {
    try {
      final User? user = currentUser;
      if (user == null) throw Exception('Usuário não está logado');

      await _firestore.collection('usuarios').doc(user.uid).delete();

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
