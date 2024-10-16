import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/cadastro_oficina/cadastro_oficina_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/cadastro_oficina/cadastro_oficina_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class AddOficinaModule {
  static const path = '/cadastrooficina';

  static GetPage page = GetPage(
    name: path,
    page: () =>  AddOficinaView(),
    binding: AddOficinaBinding(),
  );
}