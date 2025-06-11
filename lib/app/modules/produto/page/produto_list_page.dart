import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/core/constants/rotas.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_loading_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_list.dart';

class ProdutoListPage extends StatefulWidget {
  const ProdutoListPage({super.key});

  @override
  State<ProdutoListPage> createState() => _ProdutoListPageState();
}

class _ProdutoListPageState extends State<ProdutoListPage> {
  bool _isLoading = true;
  List<Produto> list = [];

  List<Produto> _produtos() {
    // TODO: Recarregar a lista vindo do controller
    // List<Produto> produtos = Provider.of<ProdutoProvider>(
    //   context,
    //   listen: listen,
    // ).produtos;
    // produtos.sort((a, b) {
    //   return a.nome.toUpperCase().compareTo(b.nome.toUpperCase());
    // });
    // return produtos;
    return [];
  }

  @override
  void initState() {
    super.initState();
    // Provider.of<ProdutoProvider>(
    //   context,
    //   listen: false,
    // ).load().then((_) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    list = _produtos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
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
      ),

      body: SafeArea(
        child:
            _isLoading
                ? WidgetLoadingPage(
                  label: 'Carregando...',
                  labelColor: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).canvasColor,
                )
                : Stack(children: [ProdutoList(produtos: _produtos())]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).textTheme.labelLarge!.color,
        onPressed: () => Navigator.of(context).pushNamed(Rotas.produtoForm),
        child: Icon(Icons.add),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
