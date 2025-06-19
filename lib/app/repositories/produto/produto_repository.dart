import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';

abstract class ProdutoRepository with ChangeNotifier {
  List<Produto> get produtos;
  void add(Produto model);
  Future<void> get();
  Future<void> post(Produto model);
  Future<void> patch(Produto model);
  Future<void> delete(Produto model);
  Future<void> save(Map<String, dynamic> map);
}
