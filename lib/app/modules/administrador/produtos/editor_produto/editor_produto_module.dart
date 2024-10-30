import 'package:boi_marronzinho/app/modules/administrador/produtos/editor_produto/editor_produto_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/produtos/editor_produto/editor_produto_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class EditorProdutoModule {
  static const path = '/editorproduto';  // Altere o caminho para refletir o contexto de produto

  static GetPage page = GetPage(
    name: path,
    page: () => EditorProdutoView(),  // Altere para EditorProdutoView
    binding: EditorProdutoBinding(),    // Altere para EditorProdutoBinding
  );
}
