import 'package:boi_marronzinho/app/modules/administrador/produtos/produtos_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/produtos/produtos_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class ProdutosAdminModule {
  static const path = '/produtosadmin';

  static GetPage page = GetPage(
    name: path,
    page: () => ProdutosAdmView(),
    binding: ProdutosAdmBinding(),
  );
}
