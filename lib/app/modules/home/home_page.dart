import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_drawer.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_about_page.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/page/carrinho_badgee.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_page.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/page/carrinho_page.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/controller/carrinho_controller.dart';
import 'package:catalogo_produto_poc/app/modules/usuario/controller/usuario_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPageIndex = 0;

  _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> pages = [
      {
        'title': '',
        'page': const ProdutoPage(
          comAppBar: false,
          produtoPageMode: ProdutoPageMode.grid,
        ),
      },
      {'title': '', 'page': const SizedBox()},
      {'title': '', 'page': const CarrinhoPage()},
      {'title': '', 'page': const WidgetAboutPage(comAppBar: false)},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('PoC', style: TextStyle(fontSize: 12)),
            const Text('Anderson Gonçalves', style: TextStyle(fontSize: 16)),
          ],
        ),

        actions: <Widget>[
          Consumer<CarrinhoController>(
            child: IconButton(
              onPressed: () {
                _selectedPageIndex = 2;
                _selectPage(_selectedPageIndex);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (ctx, carrinho, child) => carrinho.quantidadeItem > 0
                ? Badgee(
                    value: carrinho.quantidadeItem.toString(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: child!,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: child!,
                  ),
          ),
        ],
      ),
      drawer: WidgetDrawer(
        userName: context.read<UsuarioController>().user.displayName.toString(),
        userEmail: context.read<UsuarioController>().user.email ?? '',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: pages[_selectedPageIndex]['page'] as Widget),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.home),
            label: pages[0]['title'].toString(),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.credit_card),
            label: pages[1]['title'].toString(),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: Consumer<CarrinhoController>(
              child: const Icon(Icons.shopping_cart),
              builder: (ctx, carrinho, child) => carrinho.quantidadeItem > 0
                  ? Badgee(
                      value: carrinho.quantidadeItem.toString(),
                      child: child!,
                    )
                  : const Icon(Icons.shopping_cart),
            ),
            label: pages[2]['title'].toString(),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.error_outline_outlined),
            label: pages[3]['title'].toString(),
          ),
        ],
      ),
    );
  }
}
