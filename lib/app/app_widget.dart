import 'package:catalogo_produto_poc/app/modules/home/roteador_page.dart';
import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/core/constants/rotas.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_form_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_list_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Produtos',
      initialRoute: Rotas.home,
      routes: {
        Rotas.home: (_) => const RoteadorPage(),
        Rotas.produtoList: (_) => const ProdutoListPage(),
        Rotas.produtoForm: (_) => const ProdutoFormPage(),
      },
    );
  }
}
