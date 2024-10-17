import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/editor_oficina/editor_oficina_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/editor_oficina/editor_oficina_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class EditorOficinaModule {
  static const path = '/editoficina';

  static GetPage page = GetPage(
    name: path,
    page: () =>  EditorOficinaView(),
    binding: EditorOficinaBinding(),
  );
}