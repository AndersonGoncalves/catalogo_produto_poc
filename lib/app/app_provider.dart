import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:catalogo_produto_poc/app/app_widget.dart';
import 'package:catalogo_produto_poc/app/services/auth/auth_firebase_service.dart';
import 'package:catalogo_produto_poc/app/modules/produto/produto_controller.dart';
import 'package:catalogo_produto_poc/app/services/produto/produto_service.dart';
import 'package:catalogo_produto_poc/app/services/produto/produto_service_impl.dart';
import 'package:catalogo_produto_poc/app/repositories/produto/produto_repository_impl.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthFirebaseService>(
          create: (_) => AuthFirebaseService(FirebaseAuth.instance),
        ),

        ChangeNotifierProxyProvider<AuthFirebaseService, ProdutoRepositoryImpl>(
          create: (_) => ProdutoRepositoryImpl(),
          update: (ctx, auth, produtoRepository) {
            AuthFirebaseService firebaseSeFirebaseAuthService =
                AuthFirebaseService(FirebaseAuth.instance);
            return ProdutoRepositoryImpl(
              firebaseSeFirebaseAuthService.user.refreshToken.toString(),
              produtoRepository?.produtos ?? [],
            );
          },
        ),

        Provider<ProdutoService>(
          create: (context) => ProdutoServiceImpl(
            produtoRepository: context.read<ProdutoRepositoryImpl>(),
          ),
        ),

        ChangeNotifierProvider<ProdutoController>(
          create: (context) =>
              ProdutoController(produtoService: context.read<ProdutoService>()),
        ),
      ],
      child: const AppWidget(),
    );
  }
}
