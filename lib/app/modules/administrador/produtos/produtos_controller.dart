import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/produto/produto.dart';
import 'package:boi_marronzinho/app/data/repositories/produto/produto_repository.dart';
import 'package:boi_marronzinho/app/modules/administrador/produtos/cadastro_produto/cadastro_produto_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/produtos/editor_produto/editor_produto_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProdutosAdmController extends BaseController {
  final produtosRepo = ProdutoRepository();
  List<Produto> produtos = <Produto>[];

  @override
  void onInit() {
    super.onInit();
    getProdutos();
  }

  Future<void> getProdutos() async {
    setLoading(true);

    final response = await produtosRepo.fetchProdutos();
    final isValid = isValidResponse(response: response, title: 'Sucesso ao pegar lista de produtos');
    if (isValid && response.data != null) {
      produtos = response.data;
    }

    setLoading(false);
    update();
  }

  void showDeleteConfirmationDialog(
      BuildContext context, Future<void> Function() onDelete) {
    Get.dialog(
      AlertDialog(
        title: Text('Confirmação'),
        content: Text('Deseja excluir o produto?', style: TextStyle(
          fontSize: 18.sp,
        )),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); 
            },
            child: Text('Cancelar', style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
            )),
          ),
          TextButton(
            onPressed: () async {
              await onDelete();
              Get.back(); 
            },
            child: Text('Confirmar', style: TextStyle(
              fontSize: 16.sp,
              color: Colors.red,
            )),
          ),
        ],
      ),
    );
  }

  void goToEditProduto(Produto produto) {
    Get.toNamed(EditorProdutoModule.path, arguments: produto);
  }

  void onAddProdutosPressed() {
    Get.toNamed(AddProdutoModule.path);
  }

  Future<void> onDeleteProduto(Produto produto) async {
    try {
      final registerProduto = await ProdutoRepository().removeProduto(
        produtoId: produto.id,
      );
      update();
    } finally {
      setLoading(false);
    }
  }
}
