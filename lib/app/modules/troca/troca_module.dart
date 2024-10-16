import 'package:boi_marronzinho/app/modules/troca/troca_binding.dart';
import 'package:boi_marronzinho/app/modules/troca/troca_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class TrocaModule {
  static const path = '/troca';

  static GetPage page = GetPage(
    name: path,
    page: () =>  TrocaView(),
    binding: TrocaBinding(),
  );
}