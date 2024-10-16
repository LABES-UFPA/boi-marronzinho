import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/oficinas_adm_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/oficinas_adm_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class OficinasAdminModule {
  static const path = '/oficinasadmin';

  static GetPage page = GetPage(
    name: path,
    page: () =>  OficinasAdmView(),
    binding: OficinasAdmBinding(),
  );
}