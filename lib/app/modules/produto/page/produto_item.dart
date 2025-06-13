import 'package:catalogo_produto_poc/app/core/widget/widget_dialog.dart';
import 'package:catalogo_produto_poc/app/modules/produto/produto_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:catalogo_produto_poc/app/core/constants/rotas.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';

class ProdutoItem extends StatefulWidget {
  final Produto produto;
  final ProdutoController controller;

  const ProdutoItem({
    super.key,
    required this.produto,
    required this.controller,
  });

  @override
  State<ProdutoItem> createState() => _ProdutoItemState();
}

class _ProdutoItemState extends State<ProdutoItem> {
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 2,
    );

    return Dismissible(
      key: Key(widget.produto.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      confirmDismiss: (_) async {
        bool? confirmed = await WidgetDialog(context, 'Não', 'Sim').confirm(
          titulo: 'Atenção',
          pergunta: 'Deseja excluir o produto?',
          onConfirm: () async {
            return await widget.controller.remove(widget.produto);
          },
        );
        return confirmed ?? false;
      },
      child: Card(
        color: Theme.of(context).canvasColor,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
        child: ListTile(
          horizontalTitleGap: 6,
          contentPadding: EdgeInsets.only(right: 15, left: 7),
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(Rotas.produtoForm, arguments: widget.produto);
          },

          leading: const Padding(
            padding: EdgeInsets.only(left: 8, top: 7, right: 8),
            child: Icon(
              Icons.local_offer_outlined,
              color: Colors.black45,
              size: 24,
            ),
          ),

          title: Text(
            widget.produto.nome,
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          subtitle: Text(widget.produto.descricao!),

          trailing: Text(
            formatCurrency.format(widget.produto.precoDeVenda),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
