import 'package:boi_marronzinho/app/modules/administrador/contas/contas_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/contas/contas_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class ContasModule {
  static const path = '/contas';

  static GetPage page = GetPage(
    name: path,
    page: () =>  ContasView(),
    binding: ContasBinding(),
  );
}