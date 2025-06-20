import 'package:firebase_auth/firebase_auth.dart';

abstract class UsuarioService {
  User get user;
  Stream<User?> get authState;
  Future<User?> register(String name, String email, String password);
  Future<User?> login(String email, String password);
  Future<User?> googleLogin();
  Future<void> logout();
  Future<void> esqueceuSenha(String email);
  Future<void> loginAnonimo();
  Future<void> converterContaAnonimaEmPermanente(String email, String password);
}
