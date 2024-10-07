
import 'package:boi_marronzinho/app/modules/perfil/perfil_binding.dart';
import 'package:boi_marronzinho/app/modules/perfil/perfil_view.dart';
import 'package:get/get.dart';

abstract class PerfilModule {
  static const path = '/perfil';

  static GetPage page = GetPage(
    name: path,
    page: () =>  PerfilView(),
    binding: PerfilBinding(),
  );
}
