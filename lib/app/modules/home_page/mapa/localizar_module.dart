import 'package:boi_marronzinho/app/modules/home_page/mapa/localizar_binding.dart';
import 'package:boi_marronzinho/app/modules/home_page/mapa/localizar_view.dart';
import 'package:get/get.dart';

abstract class LocalizarModule {
  static const path = '/localizar';

  static GetPage page = GetPage(
      name: path, page: () => const LocalizarView(), binding: LocalizarBinding());
}
