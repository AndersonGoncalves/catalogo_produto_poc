import 'package:flutter/material.dart';

class ProdutoFormPage extends StatefulWidget {
  const ProdutoFormPage({super.key});

  @override
  State<ProdutoFormPage> createState() => _ProdutoFormPageState();
}

class _ProdutoFormPageState extends State<ProdutoFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Produto')),
      body: Container(),
    );
  }
}
