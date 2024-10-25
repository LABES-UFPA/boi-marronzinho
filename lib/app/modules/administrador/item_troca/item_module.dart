import 'package:boi_marronzinho/app/modules/administrador/item_troca/item_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/item_troca/item_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class ItemsAdminModule {
  static const path = '/itemsadmin';

  static GetPage page = GetPage(
    name: path,
    page: () => ItemsAdmView(), // Atualizado para a view de itens
    binding: ItemsAdmBinding(), // Atualizado para o binding de itens
  );
}
