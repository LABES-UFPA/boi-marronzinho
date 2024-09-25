import 'package:boi_marronzinho/app/modules/sobre_nos/sobre_nos_binding.dart';
import 'package:boi_marronzinho/app/modules/sobre_nos/sobre_nos_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class SobreNosModule {
  static const path = '/sobrenos';

  static GetPage page = GetPage(
    name: path,
    page: () =>  SobreNosView(),
    binding: SobreNosBinding(),
  );
}