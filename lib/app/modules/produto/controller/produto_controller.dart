import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/services/produto/produto_service.dart';

class ProdutoController extends ChangeNotifier {
  final ProdutoService _produtoService;

  String? error;
  bool sucess = false;
  bool isLoading = false;

  ProdutoController({required ProdutoService produtoService})
    : _produtoService = produtoService;

  List<Produto> get produtos => _produtoService.produtos;

  Future<void> load() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();
    try {
      return await _produtoService.get();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> save(Map<String, dynamic> map) async {
    error = null;
    sucess = false;
    isLoading = true;
    notifyListeners();

    try {
      await _produtoService.save(map);
      sucess = true;
    } on Exception catch (e) {
      error = 'Erro ao cadastrar produto: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> remove(Produto produto) async {
    error = null;
    sucess = false;
    isLoading = true;
    notifyListeners();
    try {
      await _produtoService.delete(produto);
      sucess = true;
    } on Exception catch (e) {
      error = 'Erro ao remover produto: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
