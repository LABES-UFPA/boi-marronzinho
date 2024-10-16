import 'package:boi_marronzinho/app/modules/cadastro/cadastro_binding.dart';
import 'package:boi_marronzinho/app/modules/cadastro/cadastro_view.dart';
import 'package:boi_marronzinho/app/modules/doacoes/doacoes_binding.dart';
import 'package:boi_marronzinho/app/modules/doacoes/doacoes_view.dart';
import 'package:get/get.dart';

abstract class CadastroModule {
  static const path = '/cadastro';

  static GetPage page = GetPage(
    name: path,
    page: () =>  CadastroView(),
    binding: CadastroBinding(),
  );
}
