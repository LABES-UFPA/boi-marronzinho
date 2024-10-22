import 'package:boi_marronzinho/app/modules/administrador/contas/editor_contas/editor_contas_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/contas/editor_contas/editor_contas_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class EditorContaModule {
  static const path = '/editorconta';

  static GetPage page = GetPage(
    name: path,
    page: () =>  EditorContaView(),
    binding: EditorContaBinding(),
  );
}