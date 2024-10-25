import 'package:boi_marronzinho/app/modules/administrador/eventos/editor_evento/editor_evento_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/eventos/editor_evento/editor_evento_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class EditorEventoModule {
  static const path = '/editoevento';

  static GetPage page = GetPage(
    name: path,
    page: () => EditorEventoView(),  // Altere para EditorEventoView
    binding: EditorEventoBinding(),    // Altere para EditorEventoBinding
  );
}
