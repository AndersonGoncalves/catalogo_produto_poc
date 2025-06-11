import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/app_widget.dart';
import 'package:catalogo_produto_poc/app/repositories/produto_repository.dart';
import 'package:catalogo_produto_poc/app/repositories/produto_repository_impl.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProdutoRepository>(
          create: (context) => ProdutoRepositoryImpl(),
        ),
      ],
      child: const AppWidget(),
    );
  }
}
