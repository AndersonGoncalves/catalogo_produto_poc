import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:catalogo_produto_poc/app/app_widget.dart';
import 'package:catalogo_produto_poc/app/core/firebase_auth_service.dart';
import 'package:catalogo_produto_poc/app/repositories/produto_repository_impl.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(FirebaseAuth.instance),
        ),
        ChangeNotifierProxyProvider<FirebaseAuthService, ProdutoRepositoryImpl>(
          create: (_) => ProdutoRepositoryImpl(),
          update: (ctx, auth, produtoRepository) {
            FirebaseAuthService firebaseSeFirebaseAuthService =
                FirebaseAuthService(FirebaseAuth.instance);
            return ProdutoRepositoryImpl(
              firebaseSeFirebaseAuthService.user.refreshToken.toString(),
              produtoRepository?.produtos ?? [],
            );
          },
        ),
      ],
      child: const AppWidget(),
    );
  }
}
