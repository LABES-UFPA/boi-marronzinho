import 'package:boi_marronzinho/app/modules/administrador/item_troca/cadastro_item/cadastro_item_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/item_troca/cadastro_item/cadastro_item_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class AddItemModule {
  static const path = '/cadastroitem';

  static GetPage page = GetPage(
    name: path,
    page: () => AddItemView(),
    binding: AddItemBinding(),
  );
}
