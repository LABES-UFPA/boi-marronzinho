import 'package:boi_marronzinho/app/modules/doacoes/doacoes_binding.dart';
import 'package:boi_marronzinho/app/modules/doacoes/doacoes_view.dart';
import 'package:get/get.dart';

abstract class DoacoesModule {
  static const path = '/doacoes';

  static GetPage page = GetPage(
    name: path,
    page: () =>  DoacoesView(),
    binding: DoacoesBinding(),
  );
}
