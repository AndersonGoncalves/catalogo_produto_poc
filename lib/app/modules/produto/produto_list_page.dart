import 'package:flutter/material.dart';

class ProdutoListPage extends StatefulWidget {
  const ProdutoListPage({super.key});

  @override
  State<ProdutoListPage> createState() => _ProdutoListPageState();
}

class _ProdutoListPageState extends State<ProdutoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listagem de Produto')),
      body: Container(),
    );
  }
}
