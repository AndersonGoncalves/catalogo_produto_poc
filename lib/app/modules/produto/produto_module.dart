import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/core/constants/rotas.dart';
import 'package:catalogo_produto_poc/app/core/modules/app_module.dart';
import 'package:catalogo_produto_poc/app/modules/produto/produto_controller.dart';
import 'package:catalogo_produto_poc/app/modules/produto/produto_form_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/produto_list_page.dart';

class ProdutoModule extends AppModule {
  ProdutoModule()
    : super(
        bindings: [
          ChangeNotifierProvider<ProdutoController>(
            create:
                (context) => ProdutoController(produtoService: context.read()),
          ),
        ],
        routers: {
          Rotas.produtoList: (_) => ProdutoListPage(),
          Rotas.produtoForm: (_) => ProdutoFormPage(),
        },
      );
}
