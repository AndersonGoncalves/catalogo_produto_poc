import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';

abstract class ProdutoRepository with ChangeNotifier {
  Future<void> load();
  Future<void> add(Produto model);
  Future<void> update(Produto model);
  Future<void> remove(Produto model);
  Future<void> save(Map<String, dynamic> map);
}
