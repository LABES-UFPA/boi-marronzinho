import 'package:boi_marronzinho/app/modules/loja/produtos/produtos_binding.dart';
import 'package:boi_marronzinho/app/modules/loja/produtos/produtos_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class ProdutosModule {
  static const path = '/produtos';

  static GetPage page = GetPage(
    name: path,
    page: () => ProdutosView(),
    binding: ProdutosBinding(),
  );
}
