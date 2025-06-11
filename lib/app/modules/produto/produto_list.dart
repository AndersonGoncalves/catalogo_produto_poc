import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_pesquisa.dart';
import 'package:catalogo_produto_poc/app/modules/produto/produto_item.dart';
import 'package:catalogo_produto_poc/app/core/widget/registro_nao_encontrado_page.dart';

class ProdutoList extends StatefulWidget {
  final List<Produto> produtos;

  const ProdutoList({super.key, required this.produtos});

  @override
  State<ProdutoList> createState() => _ProdutoListState();
}

class _ProdutoListState extends State<ProdutoList> {
  List<Produto> produtos = [];

  Future<void> _refresh(BuildContext context) {
    return Future.value(); // TODO: Recarregar a lista vindo do controller => Provider.of<ProdutoProvider>(context, listen: false).load();
  }

  @override
  void initState() {
    produtos = widget.produtos;
    super.initState();
  }

  @override
  void didUpdateWidget(ProdutoList oldWidget) {
    super.didUpdateWidget(oldWidget);
    produtos = widget.produtos;
  }

  void onChanged(String value) {
    List<Produto> list = [];
    if (value.isEmpty) {
      list = widget.produtos;
    } else {
      list =
          widget.produtos
              .where(
                (element) =>
                    (element.nome.toLowerCase().contains(value.toLowerCase())),
              )
              .toList();
    }
    setState(() {
      produtos = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refresh(context),
      child: Column(
        children: <Widget>[
          Expanded(
            child:
                widget.produtos.isNotEmpty
                    ? ListView.builder(
                      itemCount: produtos.isEmpty ? 1 : produtos.length,
                      itemBuilder:
                          (ctx, index) => Column(
                            children: <Widget>[
                              index == 0
                                  ? Container(
                                    height: 65,
                                    width: double.infinity,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: WidgetPesquisa(
                                        fillColor: Colors.white,
                                        onChanged: (value) => onChanged(value),
                                      ),
                                    ),
                                  )
                                  : SizedBox(),
                              produtos.isEmpty
                                  ? const RegistroNaoEncontradoPage()
                                  : ProdutoItem(
                                    produto: produtos[index],
                                    key: GlobalObjectKey(produtos[index]),
                                  ),
                            ],
                          ),
                    )
                    : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
