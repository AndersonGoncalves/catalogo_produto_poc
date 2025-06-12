import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/services/produto_service.dart';

class ProdutoController extends ChangeNotifier {
  final ProdutoService _produtoService;

  String? error;
  bool sucess = false;
  bool isLoading = false;

  ProdutoController({required ProdutoService produtoService})
    : _produtoService = produtoService;

  Future<void> save(Map<String, dynamic> map) async {
    if (map.isEmpty) {
      map['id'] = '';
    }

    error = null;
    sucess = false;
    isLoading = true;
    notifyListeners();

    try {
      await _produtoService.save(map);
      sucess = true;
    } on Exception catch (e) {
      error = 'Erro ao cadastrar produto';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
