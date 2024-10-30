import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/troca/item_troca.dart';
import 'package:boi_marronzinho/app/data/repositories/troca/troca_reposity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditorItemController extends BaseController {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController boicoinsController = TextEditingController();
  final TextEditingController unidadeController = TextEditingController();
  final TextEditingController quantidadeController = TextEditingController(); // Atualizado para quantidade
  final TextEditingController dateController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final GlobalKey<FormState> editItemFormKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  late ItemTroca item; // Atualize para o modelo de Item
  var selectDate = DateTime.now().obs;
  var _image = Rxn<File>();
  RxString selectedOption = ''.obs;
  File? get image => _image.value;

  @override
  void onInit() {
    super.onInit();
     item = Get.arguments as ItemTroca; // Atualize para o modelo de Item
     nomeController.text = item.nomeItem; // Atualize para o campo correto
     descricaoController.text = item.descricao; // Atualize para o campo correto
     boicoinsController.text = item.boicoinsPorUnidade.toString(); // Atualize para o campo correto
    // precoReaisController.text = item.precoReal.toString(); // Atualize para o campo correto
     quantidadeController.text = item.unidadeMedida.toString(); // Atualize para o campo correto
  }
  
  String? validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório';
    }
    return null;
  }

  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório';
    }
    final price = double.tryParse(value);
    if (price == null || price <= 0) {
      return 'Preço inválido';
    }
    return null;
  }
  String? validateBoicoins(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório';
    }
    final boicoins = double.tryParse(value);
    if (boicoins == null || boicoins <= 0) {
      return 'Valor inválido';
    }
    return null;
  }

  String? validateQuantity(String? value) { // Atualizado para quantidade
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório';
    }
    final quantity = int.tryParse(value);
    if (quantity == null || quantity <= 0) {
      return 'Quantidade inválida';
    }
    return null;
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
    }
  }

  Uint8List? base64ToImage(String base64String) {
    try {
      return Base64Decoder().convert(base64String);
    } catch (e) {
      print('Erro ao decodificar a imagem: $e');
      return null; // Retorna null em caso de erro
    }
  }

  Future<void> selectedDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2200));
    if (date != null && date != selectDate.value) {
      selectDate.value = date;
    }
  }

  Future<void> onEditItem() async {
    if (editItemFormKey.currentState?.validate() ?? false) {
      setLoading(true);
      try {
        
        

        /*final registerItem = await ItemsRepository().cadastrarItem(
          nome: nomeController.text,
          descricao: descricaoController.text,
          precoBoicoin: precoBoicoins,
          precoReal: precoReais,
          dataItem: dateController.text,
          quantidade: int.tryParse(quantidadeController.text) ?? 1,
        );*/

        Get.back();
      } finally {
        setLoading(false);
      }
    }
  }
  Future<void> onUpdateItem(String itemId) async {
  if (editItemFormKey.currentState?.validate() ?? false) {
    // try {
    //   // Obter os dados atuais do item antes de quaisquer modificações
    //   //final currentItemData = await fetchItemDataById(itemId);

    //   // Criar um mapa para armazenar as alterações
    //   final Map<String, dynamic> updatedFields = {};

    //   // Comparar os campos e adicionar ao mapa se houver alterações
    //   if (nomeController.text != currentItemData.nome) {
    //     updatedFields['nome'] = nomeController.text;
    //   }
    //   if (descricaoController.text != currentItemData.descricao) {
    //     updatedFields['descricao'] = descricaoController.text;
    //   }
    //   if (boicoinsController.text != currentItemData.boicoins.toString()) {
    //     updatedFields['boicoins'] = int.parse(boicoinsController.text);
    //   }
    //   if (selectedOption.value != currentItemData.unidadeMedida) {
    //     updatedFields['unidadeMedida'] = selectedOption.value;
    //   }

    //   // Se houver alterações, enviar para atualizar
    //   if (updatedFields.isNotEmpty) {
    //     updatedFields['id'] = itemId; // Inclui o ID para a atualização

    //     await TrocaReposity.atualizarItemTroca(updatedFields); // Atualiza apenas os campos modificados
    //     Get.snackbar('Sucesso', 'Item atualizado com sucesso!');
    //     Get.back(); // Volta para a tela anterior
    //   } else {
    //     Get.snackbar('Informação', 'Nenhuma alteração detectada.');
    //   }
    // } catch (e) {
    //   Get.snackbar('Erro', 'Não foi possível atualizar o item.');
    // }
  }
}

}
