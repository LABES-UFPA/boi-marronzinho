import 'package:boi_marronzinho/app/modules/administrador/item_troca/editor_item/editor_item_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/item_troca/editor_item/editor_item_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class EditorItemModule {
  static const path = '/edititem'; // Atualize o caminho para Item

  static GetPage page = GetPage(
    name: path,
    page: () => EditorItemView(), // Atualize para a nova view de Item
    binding: EditorItemBinding(), // Atualize para o novo binding de Item
  );
}
