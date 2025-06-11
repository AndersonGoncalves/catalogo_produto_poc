import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/services/produto_service.dart';
import 'package:catalogo_produto_poc/app/repositories/produto_repository.dart';

class ProdutoServiceImpl implements ProdutoService {
  final ProdutoRepository _produtoRepository;

  ProdutoServiceImpl({required ProdutoRepository produtoRepository})
    : _produtoRepository = produtoRepository;

  @override
  Future<void> load() => _produtoRepository.load();

  @override
  Future<void> add(Produto model) => _produtoRepository.add(model);

  @override
  Future<void> update(Produto model) => _produtoRepository.update(model);

  @override
  Future<void> remove(Produto model) => _produtoRepository.remove(model);

  @override
  Future<void> save(Map<String, dynamic> map) => _produtoRepository.save(map);
}
