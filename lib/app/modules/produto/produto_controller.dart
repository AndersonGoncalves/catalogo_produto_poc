import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/services/produto_service.dart';

class ProdutoController extends ChangeNotifier {
  final ProdutoService _produtoService;

  ProdutoController({required ProdutoService produtoService})
    : _produtoService = produtoService;
}
