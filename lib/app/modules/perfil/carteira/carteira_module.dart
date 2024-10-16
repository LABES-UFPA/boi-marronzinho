import 'package:boi_marronzinho/app/modules/carteira/carteira_binding.dart';
import 'package:boi_marronzinho/app/modules/carteira/carteira_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class CarteiraModule {
  static const path = '/carteira';

  static GetPage page = GetPage(
    name: path,
    page: () => CarteiraView(),
    binding: CarteiraBinding(),
  );
}
