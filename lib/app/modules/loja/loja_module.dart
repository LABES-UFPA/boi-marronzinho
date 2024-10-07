import 'package:boi_marronzinho/app/modules/loja/loja_binding.dart';
import 'package:boi_marronzinho/app/modules/loja/loja_view.dart';
import 'package:get/get.dart';

abstract class LojaModule {
  static const path = '/loja';

  static GetPage page = GetPage(
    name: path,
    page: () =>  LojaView(),
    binding: LojaBinding(),
  );
}
