import 'package:boi_marronzinho/app/modules/administrador/produtos/cadastro_produto/cadastro_produto_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/produtos/cadastro_produto/cadastro_produto_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class AddProdutoModule {
  static const path = '/cadastroproduto';

  static GetPage page = GetPage(
    name: path,
    page: () => AddProdutoView(),
    binding: AddProdutoBinding(),
  );
}
