import 'package:boi_marronzinho/app/modules/perfil/meus_dados/meus_dados_binding.dart';
import 'package:boi_marronzinho/app/modules/perfil/meus_dados/meus_dados_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class MeusDadosModule {
  static const path = '/meusdados';

  static GetPage page = GetPage(
    name: path,
    page: () => MeusDadosView(),
    binding: MeusDadosBinding(),
  );
}
