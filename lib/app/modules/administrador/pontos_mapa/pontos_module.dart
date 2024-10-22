import 'package:boi_marronzinho/app/modules/administrador/pontos_mapa/pontos_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/pontos_mapa/pontos_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class PontosAdminModule {
  static const path = '/pontosadmin';

  static GetPage page = GetPage(
    name: path,
    page: () => PontosAdmView(),
    binding: PontosAdmBinding(),
  );
}
