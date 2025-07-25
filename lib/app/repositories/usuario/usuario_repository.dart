import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UsuarioRepository with ChangeNotifier {
  User get user;
  Stream<User?> get authState;
  Future<User?> register(String name, String email, String password);
  Future<User?> login(String email, String password);
  Future<User?> googleLogin();
  Future<User?> loginAnonimo();
  Future<User?> converterContaAnonimaEmPermanente(
    String email,
    String password,
  );
  Future<void> logout();
  Future<void> esqueceuSenha(String email);
}
