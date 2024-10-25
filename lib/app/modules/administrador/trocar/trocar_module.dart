import 'package:boi_marronzinho/app/modules/administrador/trocar/trocar_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/trocar/trocar_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class TrocarModule {
  static const path = '/trocar'; // Atualize o caminho, se necessário

  static GetPage page = GetPage(
    name: path,
    page: () => TrocarView(), // Atualize o nome da view, se necessário
    binding: TrocarBinding(), // Atualize o nome do binding, se necessário
  );
}
