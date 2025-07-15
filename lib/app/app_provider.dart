import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:catalogo_produto_poc/app/app_widget.dart';
import 'package:catalogo_produto_poc/app/modules/usuario/controller/usuario_controller.dart';
import 'package:catalogo_produto_poc/app/services/usuario/usuario_service_impl.dart';
import 'package:catalogo_produto_poc/app/services/produto/produto_service_impl.dart';
import 'package:catalogo_produto_poc/app/modules/produto/controller/produto_controller.dart';
import 'package:catalogo_produto_poc/app/repositories/produto/produto_repository_impl.dart';
import 'package:catalogo_produto_poc/app/repositories/usuario/usuario_repository_impl.dart';
import 'package:catalogo_produto_poc/app/repositories/carrinho/carrinho_repository_impl.dart';
import 'package:catalogo_produto_poc/app/services/carrinho/carrinho_service_impl.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/controller/carrinho_controller.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Usuario
        Provider<UsuarioRepositoryImpl>(
          create: (_) =>
              UsuarioRepositoryImpl(firebaseAuth: FirebaseAuth.instance),
        ),
        Provider<UsuarioServiceImpl>(
          create: (context) => UsuarioServiceImpl(
            usuarioRepository: context.read<UsuarioRepositoryImpl>(),
          ),
        ),
        ChangeNotifierProvider<UsuarioController>(
          create: (context) => UsuarioController(
            usuarioService: context.read<UsuarioServiceImpl>(),
          ),
        ),

        //Produto
        ChangeNotifierProxyProvider<
          UsuarioRepositoryImpl,
          ProdutoRepositoryImpl
        >(
          create: (_) => ProdutoRepositoryImpl(),
          update: (ctx, auth, produtoRepository) {
            UsuarioRepositoryImpl usuarioService = UsuarioRepositoryImpl(
              firebaseAuth: FirebaseAuth.instance,
            );
            return ProdutoRepositoryImpl(
              token: usuarioService.user.refreshToken.toString(),
              produtos: produtoRepository?.produtos ?? [],
            );
          },
        ),
        Provider<ProdutoServiceImpl>(
          create: (context) => ProdutoServiceImpl(
            produtoRepository: context.read<ProdutoRepositoryImpl>(),
          ),
        ),
        ChangeNotifierProvider<ProdutoController>(
          create: (context) => ProdutoController(
            produtoService: context.read<ProdutoServiceImpl>(),
          ),
        ),

        //Carrinho
        ChangeNotifierProvider<CarrinhoRepositoryImpl>(
          create: (context) => CarrinhoRepositoryImpl(),
        ),
        ChangeNotifierProvider<CarrinhoServiceImpl>(
          create: (context) => CarrinhoServiceImpl(
            carrinhoRepository: context.read<CarrinhoRepositoryImpl>(),
          ),
        ),
        ChangeNotifierProvider<CarrinhoController>(
          create: (context) => CarrinhoController(
            carrinhoService: context.read<CarrinhoServiceImpl>(),
          ),
        ),
      ],
      child: const AppWidget(),
    );
  }
}
