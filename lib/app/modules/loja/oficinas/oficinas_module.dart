import 'package:boi_marronzinho/app/modules/loja/oficinas/oficinas_binding.dart';
import 'package:boi_marronzinho/app/modules/loja/oficinas/oficinas_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class OficinasModule {
  static const path = '/oficinas';

  static GetPage page = GetPage(
    name: path,
    page: () => OficinasView(),
    binding: OficinasBinding(),
  );
}
