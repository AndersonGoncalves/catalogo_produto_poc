import 'package:catalogo_produto_poc/app/modules/usuario/page/usuario_form_page.dart';
import 'package:catalogo_produto_poc/app/repositories/usuario/usuario_repository.dart';
import 'package:catalogo_produto_poc/app/services/usuario/usuario_service_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeUsuarioRepository extends UsuarioRepository {
  @override
  Stream<User?> get authState => throw UnimplementedError();

  @override
  Future<User?> converterContaAnonimaEmPermanente(
    String email,
    String password,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<void> esqueceuSenha(String email) {
    throw UnimplementedError();
  }

  @override
  Future<User?> googleLogin() {
    throw UnimplementedError();
  }

  @override
  Future<User?> login(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<User?> loginAnonimo() {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<User?> register(String name, String email, String password) {
    throw UnimplementedError();
  }

  @override
  User get user => throw UnimplementedError();
}

class MockUsuarioServiceImpl extends UsuarioServiceImpl {
  MockUsuarioServiceImpl() : super(usuarioRepository: FakeUsuarioRepository());
}

void main() async {
  group('testes do campo email', () {
    testWidgets(
      'deve exibir o campo de email na tela quando estiver com usuario anônimo',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Provider<UsuarioServiceImpl>(
              create: (_) => MockUsuarioServiceImpl(),
              child: const UsuarioFormPage(usuarioAnonimo: true),
            ),
          ),
        );

        final emailField = find.byKey(const Key('email_key'));
        expect(emailField, findsOneWidget);
      },
    );

    testWidgets('deve exibir a mensagem de email inválido', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Provider<UsuarioServiceImpl>(
            create: (_) => MockUsuarioServiceImpl(),
            child: const UsuarioFormPage(usuarioAnonimo: true),
          ),
        ),
      );

      final entrarButton = find.byKey(const Key('usuario_form_entrar_key'));
      await tester.tap(entrarButton);
      await tester.pumpAndSettle();
      final emailError = find.text('Informe um email válido');
      expect(emailError, findsOneWidget);
    });
  });
}
