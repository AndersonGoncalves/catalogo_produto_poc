// import 'package:flutter/material.dart';
// import '../../../core/notifier/default_change_notifier.dart';
// import '../../../exception/auth_exception.dart';
// import '../../../services/user/user_service.dart';

// class AuthController extends ChangeNotifier {
//   final UserService _userService;
//   String? infoMessage;
//   AuthController({required UserService userService})
//     : _userService = userService;

//   bool get hasInfo => infoMessage != null;

//   Future<void> googleLogin() async {
//     try {
//       showLoadingAndResetState();
//       infoMessage = null;
//       notifyListeners();

//       final user = await _userService.googleLogin();

//       if (user != null) {
//         sucess();
//       } else {
//         _userService.logout();
//         setError('Erro ao realizar login com google');
//       }
//     } on AuthException catch (e) {
//       _userService.logout();
//       setError(e.message);
//     } finally {
//       hideLoading();
//       notifyListeners();
//     }
//   }

//   Future<void> login(String email, String password) async {
//     try {
//       showLoadingAndResetState();
//       infoMessage = null;
//       notifyListeners();

//       final user = await _userService.login(email, password);

//       if (user != null) {
//         sucess();
//       } else {
//         setError('Usuário ou senha inválida');
//       }
//     } on AuthException catch (e) {
//       setError(e.message);
//     } finally {
//       hideLoading();
//       notifyListeners();
//     }
//   }

//   Future<void> forgotPassword(String email) async {
//     try {
//       showLoadingAndResetState();
//       infoMessage = null;
//       notifyListeners();

//       await _userService.forgotPassword(email);
//       infoMessage = 'Reset de senha enviado para seu email';
//     } on AuthException catch (e) {
//       setError(e.message);
//     } catch (e) {
//       setError('Erro ao resetar senha');
//     } finally {
//       hideLoading();
//       notifyListeners();
//     }
//   }

//   Future<void> registerUser(String email, String password) async {
//     try {
//       showLoadingAndResetState();
//       notifyListeners();

//       final user = await _userService.register(email, password);

//       if (user != null) {
//         sucess();
//       } else {
//         setError('Erro ao registrar usuário');
//       }
//     } on AuthException catch (e) {
//       setError(e.message);
//     } finally {
//       hideLoading();
//       notifyListeners();
//     }
//   }
// }
