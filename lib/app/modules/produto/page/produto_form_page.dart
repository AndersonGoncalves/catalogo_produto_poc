import 'package:catalogo_produto_poc/app/core/ui/functions.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/core/models/produto.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_loading_page.dart';
import 'package:catalogo_produto_poc/app/core/widget/widget_text_form_field.dart';
import 'package:catalogo_produto_poc/app/modules/produto/produto_controller.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class ProdutoFormPage extends StatefulWidget {
  const ProdutoFormPage({super.key});

  @override
  State<ProdutoFormPage> createState() => _ProdutoFormPageState();
}

class _ProdutoFormPageState extends State<ProdutoFormPage> {
  bool _isLoading = false;
  Map<String, dynamic> _formData = <String, dynamic>{};
  List<String> _fotoList = [];
  final _formKey = GlobalKey<FormState>();

  final _nomeFocus = FocusNode();
  final _precoVendaFocus = FocusNode();
  final _precoCustoFocus = FocusNode();
  final _marcaFocus = FocusNode();
  final _descricaoFocus = FocusNode();

  final _precoCustoController = TextEditingController();
  final _precoVendaController = TextEditingController();

  NumberFormat formatCurrency(BuildContext context) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: '');
  }

  CurrencyTextInputFormatter currencyTextInputFormatter(
    BuildContext context, {
    int decimalDigits = 2,
  }) {
    return CurrencyTextInputFormatter.currency(
      locale: 'pt_BR',
      symbol: '',
      decimalDigits: decimalDigits,
      turnOffGrouping: true,
    );
  }

  void _setValoresInicial() {
    _formData['id'] = '';
    _formData['nome'] = '';
    _formData['precoDeVenda'] = 0.0;
    _formData['precoDeCusto'] = 0.0;
    _formData['marca'] = '';
    _formData['descricao'] = '';
  }

  Future<void> _save() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      _formKey.currentState?.save();
      await context.read<ProdutoController>().save(_formData);
    }
  }

  @override
  void initState() {
    super.initState();

    context.read<ProdutoController>().addListener(() {
      final controller = context.read<ProdutoController>();
      var error = controller.error;
      var sucess = controller.sucess;
      setState(() => _isLoading = controller.isLoading);
      if (sucess) {
        Navigator.of(context).pop();
      } else if (error != null && error.isNotEmpty) {
        if (mounted) {
          showSnackBar(context, error, Colors.red);
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      bool visualizandoDados = (arg != null);
      if (visualizandoDados) {
        final produto = arg as Produto;
        _formData = produto.toMap();
        _precoVendaController.text = _formData['precoDeVenda'].toStringAsFixed(
          2,
        );
        _precoCustoController.text = _formData['precoDeCusto'].toStringAsFixed(
          2,
        );
      } else {
        _setValoresInicial();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _fotoList.clear();
    _nomeFocus.dispose();
    _descricaoFocus.dispose();
    _precoVendaFocus.dispose();
    _precoCustoFocus.dispose();
    context.read<ProdutoController>().removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? WidgetLoadingPage(
              label: 'Salvando...',
              labelColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Colors.white,
            )
          : Form(
              key: _formKey,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverAppBar(
                            elevation: 0,
                            toolbarHeight: 56,
                            automaticallyImplyLeading: true,
                            pinned: true,
                            expandedHeight: _fotoList.isEmpty ? 56 : 300,
                            flexibleSpace: FlexibleSpaceBar(
                              title: Text('Produto'),
                              background: _fotoList.isEmpty
                                  ? const SizedBox()
                                  : Image.network(
                                      _fotoList[0],
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                            foregroundColor: Colors.black,

                            leading: IconButton(
                              onPressed: Navigator.of(context).pop,
                              icon: const Icon(Icons.arrow_back_ios, size: 20),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate(<Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    WidgetTextFormField(
                                      labelText: 'Nome',
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      focusNode: _nomeFocus,
                                      initialValue: _formData['nome']
                                          ?.toString(),
                                      validator: (value) {
                                        final nome = value ?? '';
                                        if (nome.trim().isEmpty) {
                                          return 'Nome é obrigatório';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) =>
                                          _formData['nome'] = value ?? '',
                                      onFieldSubmitted: (_) => FocusScope.of(
                                        context,
                                      ).requestFocus(_precoCustoFocus),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: SizedBox(
                                              child: WidgetTextFormField(
                                                labelText: 'Preço de Custo',
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: _precoCustoFocus,
                                                inputFormatters: [
                                                  currencyTextInputFormatter(
                                                    context,
                                                  ),
                                                ],
                                                controller:
                                                    _precoCustoController,
                                                validator: (value) {
                                                  final nome = value ?? '';
                                                  if (nome.trim().isEmpty) {
                                                    return 'Preço de custo é obrigatório';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) =>
                                                    _formData['precoDeCusto'] =
                                                        value ?? 0.00,
                                                onFieldSubmitted: (_) =>
                                                    FocusScope.of(
                                                      context,
                                                    ).requestFocus(
                                                      _precoVendaFocus,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: SizedBox(
                                              child: WidgetTextFormField(
                                                labelText: 'Preço de Venda',
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                suffixIcon: const Icon(
                                                  Icons.calculate_outlined,
                                                ),

                                                focusNode: _precoVendaFocus,
                                                inputFormatters: [
                                                  currencyTextInputFormatter(
                                                    context,
                                                  ),
                                                ],
                                                controller:
                                                    _precoVendaController,
                                                validator: (value) {
                                                  final nome = value ?? '';
                                                  if (nome.trim().isEmpty) {
                                                    return 'Preço de venda é obrigatório';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) =>
                                                    _formData['precoDeVenda'] =
                                                        value ?? 0.00,
                                                onFieldSubmitted: (_) =>
                                                    FocusScope.of(
                                                      context,
                                                    ).requestFocus(_marcaFocus),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  bottom: 15,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    WidgetTextFormField(
                                      labelText: 'Marca',
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      focusNode: _marcaFocus,
                                      initialValue: _formData['marca']
                                          ?.toString(),
                                      onSaved: (value) =>
                                          _formData['marca'] = value ?? '',
                                      onFieldSubmitted: (_) => FocusScope.of(
                                        context,
                                      ).requestFocus(_descricaoFocus),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 15,
                                        top: 10,
                                      ),
                                      child: WidgetTextFormField(
                                        labelText: 'Descrição',
                                        keyboardType: TextInputType.multiline,
                                        textInputAction:
                                            TextInputAction.newline,
                                        focusNode: _descricaoFocus,
                                        initialValue: _formData['descricao']
                                            ?.toString(),
                                        validator: (value) {
                                          return null;
                                        },
                                        onSaved: (value) =>
                                            _formData['descricao'] =
                                                value ?? '',
                                        maxLines: null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 10,
                      ),
                      child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize: Size(double.infinity, 45),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text('Salvar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
