import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/core/ui/messages.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/core/constants/rotas.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_loading_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_list.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_grid.dart';
import 'package:catalogo_produto_poc/app/modules/produto/controller/produto_controller.dart';

enum ProdutoPageMode { list, grid }

class ProdutoPage extends StatefulWidget {
  final bool _comAppBar;
  final ProdutoPageMode _produtoPageMode;
  const ProdutoPage({
    super.key,
    bool comAppBar = true,
    required ProdutoPageMode produtoPageMode,
  }) : _comAppBar = comAppBar,
       _produtoPageMode = produtoPageMode;

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  bool _isLoading = true;

  List<Produto> _produtos() {
    List<Produto> produtos = context.read<ProdutoController>().produtos;
    produtos.sort((a, b) {
      return a.nome.toUpperCase().compareTo(b.nome.toUpperCase());
    });
    return produtos;
  }

  void _onController() {
    if (mounted) {
      final controller = context.read<ProdutoController>();
      setState(() => _isLoading = controller.isLoading);

      var error = controller.error;
      var sucess = controller.sucess;
      if (!sucess && error != null && error.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            Messages.of(context).showError(error);
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // Future.microtask para executar após o frame atual
    Future.microtask(() async {
      if (mounted) {
        final controller = context.read<ProdutoController>();
        await controller.load();
      }
    });

    final controller = context.read<ProdutoController>();
    controller.addListener(_onController);
  }

  @override
  void dispose() {
    final controller = context.read<ProdutoController>();
    controller.removeListener(_onController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: widget._comAppBar
          ? AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              surfaceTintColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              toolbarHeight: 56,
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.arrow_back_ios, size: 20),
              ),
              title: Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Text('Produtos', style: TextStyle(color: Colors.white)),
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Rotas.produtoForm);
                  },
                ),
              ],
            )
          : null,
      body: SafeArea(
        child: _isLoading
            ? WidgetLoadingPage(
                label: 'Carregando...',
                labelColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).canvasColor,
              )
            : widget._produtoPageMode == ProdutoPageMode.list
            ? ProdutoList(produtos: _produtos())
            : ProdutoGrid(produtos: _produtos()),
      ),
      floatingActionButton: widget._produtoPageMode == ProdutoPageMode.list
          ? FloatingActionButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(Rotas.produtoForm),
              child: Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
