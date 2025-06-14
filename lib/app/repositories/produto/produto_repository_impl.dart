import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:catalogo_produto_poc/app/core/constants/url.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/repositories/produto/produto_repository.dart';

class ProdutoRepositoryImpl extends ProdutoRepository {
  String token;
  final List<Produto> _produtos;
  ProdutoRepositoryImpl([this.token = '', this._produtos = const []]);

  @override
  List<Produto> get produtos => [..._produtos];

  @override
  Future<void> load() async {
    _produtos.clear();
    final response = await http.get(
      Uri.parse('${Url.firebase().produto}.json?auth=$token'),
    );
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((modelId, modelData) {
      modelData['id'] = modelId;
      _produtos.add(Produto.fromMap(modelData, true));
    });
    notifyListeners();
  }

  @override
  Future<void> add(Produto model) async {
    final response = await http.post(
      Uri.parse('${Url.firebase().produto}.json?auth=$token'),
      body: model.toJson(),
    );
    final id = jsonDecode(response.body)['name'];
    _produtos.add(model.copyWith(id: id));
    notifyListeners();
  }

  @override
  Future<void> update(Produto model) async {
    int index = _produtos.indexWhere((p) => p.id == model.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse('${Url.firebase().produto}/${model.id}.json?auth=$token'),
        body: model.toJson(),
      );
      _produtos[index] = model;
      notifyListeners();
    }
  }

  @override
  Future<void> remove(Produto model) async {
    int index = _produtos.indexWhere((p) => p.id == model.id);
    if (index >= 0) {
      final model = _produtos[index];
      _produtos.remove(model);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Url.firebase().produto}/${model.id}.json?auth=$token'),
        body: model.toJson(),
      );

      if (response.statusCode >= 400) {
        _produtos.insert(index, model);
        notifyListeners();
        // throw HttpException(
        //   msg: 'Falha ao excluir o produto',
        //   statusCode: response.statusCode,
        // );
      }
    }
  }

  @override
  Future<void> save(Map<String, dynamic> map) {
    final model = Produto.fromMap(map, false);
    if (model.id == '') {
      return add(model);
    } else {
      return update(model);
    }
  }
}
