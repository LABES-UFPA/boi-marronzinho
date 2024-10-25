import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/troca/item_troca.dart';
import 'package:boi_marronzinho/app/data/models/troca/troca.dart';
import 'package:boi_marronzinho/app/data/repositories/troca/troca_reposity.dart';
import 'package:boi_marronzinho/app/modules/administrador/item_troca/cadastro_item/cadastro_item_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/item_troca/editor_item/editor_item_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemController extends BaseController {
  final itemsRepo = TrocaReposity(); // Ajuste para o repositório de itens
  List<ItemTroca> items = <ItemTroca>[]; // Ajuste conforme o tipo de item

  @override
  void onInit() {
    super.onInit();
    getItems(); // Método para buscar itens
  }

  Future<void> getItems() async {
    setLoading(true);

    final response = await itemsRepo.getItensTroca(); // Método para buscar itens
    final isValid = isValidResponse(response: response, title: response.reason);
    if (isValid && response.data != null) {
      items = response.data; // Armazena a lista de itens
    }

    setLoading(false);
    update();
  }

  void showDeleteConfirmationDialog(
      BuildContext context, Future<void> Function() onDelete) {
    Get.dialog(
      AlertDialog(
        title: Text('Confirmação'),
        content: Text('Deseja excluir o item?', style: TextStyle(
          fontSize: 18.sp
        )),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); 
            },
            child: Text('Cancelar', style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black
            )),
          ),
          TextButton(
            onPressed: () async {
              await onDelete();
              Get.back(); 
            },
            child: Text('Confirmar', style: TextStyle(
              fontSize: 16.sp,
              color: Colors.red
            )),
          ),
        ],
      ),
    );
  }

  void goToEditItem(ItemTroca item) {
    Get.toNamed(EditorItemModule.path, arguments: item); // Ajuste conforme o caminho do módulo de edição
  }

  void onAddItemsPressed() {
    Get.toNamed(AddItemModule.path); // Ajuste conforme o caminho do módulo de cadastro
  }

  Future<void> onDeleteItem(ItemTroca item) async {
    try {
      final deleteResponse = await itemsRepo.deletarItemTroca(id: item.id); // Método para deletar item
      items.removeWhere((i) => i.id == item.id); // Remove o item da lista
      update();
    } finally {
      setLoading(false);
    }
  }
}
