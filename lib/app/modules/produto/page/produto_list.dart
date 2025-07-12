import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_pesquisa.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_list_item.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_registro_nao_encontrado_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/controller/produto_controller.dart';

class ProdutoList extends StatefulWidget {
  final List<Produto> _produtos;

  const ProdutoList({super.key, required List<Produto> produtos})
    : _produtos = produtos;

  @override
  State<ProdutoList> createState() => _ProdutoListState();
}

class _ProdutoListState extends State<ProdutoList> {
  List<Produto> produtos = [];

  Future<void> _refresh(BuildContext context) {
    return context.read<ProdutoController>().load();
  }

  void _onSearch(String value) {
    List<Produto> search = [];
    if (value.isEmpty) {
      search = widget._produtos;
    } else {
      search = widget._produtos
          .where(
            (element) =>
                (element.nome.toLowerCase().contains(value.toLowerCase())),
          )
          .toList();
    }
    setState(() {
      produtos = search;
    });
  }

  @override
  void initState() {
    produtos = widget._produtos;
    super.initState();
  }

  @override
  void didUpdateWidget(ProdutoList oldWidget) {
    super.didUpdateWidget(oldWidget);
    produtos = widget._produtos;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refresh(context),
      child: Column(
        children: <Widget>[
          Expanded(
            child: widget._produtos.isNotEmpty
                ? ListView.builder(
                    itemCount: produtos.isEmpty ? 1 : produtos.length,
                    itemBuilder: (ctx, index) => Column(
                      children: <Widget>[
                        index == 0
                            ? Container(
                                height: 65,
                                width: double.infinity,
                                color: Theme.of(context).colorScheme.primary,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: WidgetPesquisa(
                                    fillColor: Colors.white,
                                    onSearch: (value) => _onSearch(value),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                        produtos.isEmpty
                            ? const WidgetRegistroNaoEncontradoPage()
                            : ProdutoListItem(
                                key: Key('list_${produtos[index].id}'),
                                produto: produtos[index],
                              ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
