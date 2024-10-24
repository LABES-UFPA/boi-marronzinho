import 'package:boi_marronzinho/app/modules/administrador/eventos/cadastro_evento/cadastro_evento_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/eventos/cadastro_evento/cadastro_evento_view.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/cadastro_oficina/cadastro_oficina_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/cadastro_oficina/cadastro_oficina_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class AddEventoModule {
  static const path = '/cadastroevento';

  static GetPage page = GetPage(
    name: path,
    page: () =>  AddEventoView(),
    binding: AddEventoBinding(),
  );
}