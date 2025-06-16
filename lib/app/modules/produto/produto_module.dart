import 'package:provider/provider.dart';
import 'package:catalogo_produto_poc/app/core/constants/rotas.dart';
import 'package:catalogo_produto_poc/app/core/modules/app_module.dart';
import 'package:catalogo_produto_poc/app/services/produto/produto_service.dart';
import 'package:catalogo_produto_poc/app/services/produto/produto_service_impl.dart';
import 'package:catalogo_produto_poc/app/modules/produto/produto_controller.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_form_page.dart';
import 'package:catalogo_produto_poc/app/modules/produto/page/produto_list_page.dart';
import 'package:catalogo_produto_poc/app/repositories/produto/produto_repository_impl.dart';

class ProdutoModule extends AppModule {
  ProdutoModule()
    : super(
        bindings: [
          Provider<ProdutoService>(
            create: (context) => ProdutoServiceImpl(
              produtoRepository: context.read<ProdutoRepositoryImpl>(),
            ),
          ),

          ChangeNotifierProvider<ProdutoController>(
            create: (context) => ProdutoController(
              produtoService: context.read<ProdutoService>(),
            ),
          ),
        ],
        routers: {
          Rotas.produtoList: (_) => ProdutoListPage(),
          Rotas.produtoForm: (_) => ProdutoFormPage(),
        },
      );
}
