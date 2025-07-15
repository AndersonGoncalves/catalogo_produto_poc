import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/core/models/carrinho.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/services/carrinho/carrinho_service.dart';

class CarrinhoController extends ChangeNotifier {
  final CarrinhoService _carrinhoService;

  String? error;
  bool sucess = false;
  bool isLoading = false;

  CarrinhoController({required CarrinhoService carrinhoService})
    : _carrinhoService = carrinhoService;

  Map<String, Carrinho> get items => _carrinhoService.items;

  int get quantidadeItem => _carrinhoService.quantidadeItem;

  double get valorTotal => _carrinhoService.valorTotal;

  void add(Produto produto) {
    isLoading = true;
    notifyListeners();
    try {
      _carrinhoService.add(produto);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void remove(String produtoId) {
    isLoading = true;
    notifyListeners();
    try {
      _carrinhoService.remove(produtoId);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void removeSingleItem(String produtoId) {
    isLoading = true;
    notifyListeners();
    try {
      _carrinhoService.removeSingleItem(produtoId);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    isLoading = true;
    notifyListeners();
    try {
      _carrinhoService.clear();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
