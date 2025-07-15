import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:catalogo_produto_poc/app/core/exceptions/auth_exception.dart';
import 'package:catalogo_produto_poc/app/services/usuario/usuario_service_impl.dart';

class UsuarioController extends ChangeNotifier {
  final UsuarioServiceImpl _usuarioService;

  String? error;
  bool sucess = false;
  bool isLoading = false;

  User get user => _usuarioService.user;

  Stream<User?> get authState => _usuarioService.authState;

  UsuarioController({required UsuarioServiceImpl usuarioService})
    : _usuarioService = usuarioService;

  Future<void> register(String name, String email, String password) async {
    error = null;
    sucess = false;
    isLoading = true;
    notifyListeners();

    try {
      final user = await _usuarioService.register(name, email, password);

      if (user != null) {
        sucess = true;
      } else {
        error = 'Erro ao registrar usuário';
      }
    } on AuthException catch (e) {
      error = 'Erro ao registrar usuário: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    error = null;
    sucess = false;
    isLoading = true;
    notifyListeners();
    try {
      final user = await _usuarioService.login(email, password);

      if (user != null) {
        sucess = true;
      } else {
        error = 'Usuário ou senha inválida';
      }
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> googleLogin() async {
    error = null;
    sucess = false;
    isLoading = true;
    notifyListeners();
    try {
      final user = await _usuarioService.googleLogin();

      if (user != null) {
        sucess = true;
      } else {
        _usuarioService.logout();
        error = 'Erro ao realizar login com google';
      }
    } on AuthException catch (e) {
      _usuarioService.logout();
      error = 'Erro ao realizar login com google: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginAnonimo() async {
    error = null;
    sucess = false;
    isLoading = true;
    notifyListeners();
    try {
      await _usuarioService.loginAnonimo();
      sucess = true;
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> converterContaAnonimaEmPermanente(
    String email,
    String password,
  ) async {
    error = null;
    sucess = false;
    isLoading = true;
    notifyListeners();
    try {
      final user = await _usuarioService.converterContaAnonimaEmPermanente(
        email,
        password,
      );

      if (user != null) {
        sucess = true;
      } else {
        error = 'Não foi ppossível converter o usuário anônimo';
      }
    } on AuthException catch (e) {
      error = 'Não foi ppossível converter o usuário anônimo: ${e.message}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    error = null;
    sucess = false;
    isLoading = true;
    notifyListeners();
    try {
      await _usuarioService.logout();
      sucess = true;
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> esqueceuSenha(String email) async {
    error = null;
    sucess = false;
    isLoading = true;
    notifyListeners();
    try {
      await _usuarioService.esqueceuSenha(email);
    } on AuthException catch (e) {
      error = e.message;
    } catch (e) {
      error = 'Erro ao resetar senha: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
