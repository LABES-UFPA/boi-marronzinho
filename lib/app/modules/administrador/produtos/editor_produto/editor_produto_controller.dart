import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/enumerators/endpoints.enum.dart';
import 'package:boi_marronzinho/app/data/models/produto/produto.dart';
import 'package:boi_marronzinho/app/data/repositories/produto/produto_repository.dart';
import 'package:boi_marronzinho/app/data/util/api/api_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditorProdutoController extends BaseController {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precoBoicoinsController = TextEditingController();
  final TextEditingController precoReaisController = TextEditingController();
  final TextEditingController quantidadeEstoqueController = TextEditingController();
  final GlobalKey<FormState> editProdutoFormKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  late Produto produto;
  var selectDate = DateTime.now().obs;
  File? imagem;
  var url='';
  var _image = Rxn<File>();
  File? get image => _image.value;

  @override
  void onInit() {
    super.onInit();
    produto = Get.arguments as Produto;
    nomeController.text = produto.nome;
    descricaoController.text = produto.descricao;
    precoBoicoinsController.text = produto.precoBoicoins.toString();
    precoReaisController.text = produto.precoReal.toString();
    quantidadeEstoqueController.text = produto.quantidadeEmEstoque.toString();
    url = ApiHelpers().buildUrl(
      url: produto.imagemURL,
      endpoint: Endpoints.MINIO
    );
    print(url);
    print("${produto.imagemURL}");

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

  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório';
    }
    final quantity = int.tryParse(value);
    if (quantity == null || quantity < 0) {
      return 'Quantidade inválida';
    }
    return null;
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
      imagem = File(pickedFile.path);
    }
  }

  Uint8List? base64ToImage(String base64String) {
    try {
      return Base64Decoder().convert(base64String);
    } catch (e) {
      print('Erro ao decodificar a imagem: $e');
      return null;
    }
  }

  // Future<void> onEditProduto() async {
  //   if (editProdutoFormKey.currentState?.validate() ?? false) {
  //     setLoading(true);
  //     try {
  //       final registerProduto = await ProdutoRepository().editarProduto(
  //         id: produto.id,
  //         nome: nomeController.text,
  //         descricao: descricaoController.text,
  //         precoBoicoins: double.parse(precoBoicoinsController.text),
  //         precoReal: double.parse(precoReaisController.text),
  //         quantidadeEmEstoque: int.parse(quantidadeEstoqueController.text),
  //         imagem: imagem!,
  //       );

  //       if (registerProduto.valid) {
  //         Get.back();
  //       } else {
  //         print("Erro ao editar o produto: ${registerProduto.reason}");
  //       }
  //     } catch (e) {
  //       print("Erro ao editar o produto: $e");
  //     } finally {
  //       setLoading(false);
  //     }
  //   }
  // }
}
