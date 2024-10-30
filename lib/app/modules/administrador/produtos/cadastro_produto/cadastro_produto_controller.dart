import 'dart:io';
import 'package:boi_marronzinho/app/data/repositories/produto/produto_repository.dart';
import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/global_ui/components/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProdutoController extends BaseController {
  final ProdutoRepository produtoRepository = ProdutoRepository();
  final GlobalKey<FormState> registerProdutoFormKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precoBoicoinsController = TextEditingController();
  final TextEditingController precoRealController = TextEditingController();
  final TextEditingController quantidadeController = TextEditingController();
  final GlobalKey<FormState> endProdutoFormKey = GlobalKey<FormState>();

  Map<String, dynamic>? addressData;
  final ImagePicker _picker = ImagePicker();
  var address = ''.obs;
  var isLoading = false.obs;
  var selectDate = DateTime.now().obs;
  var _image = Rxn<File>();
  File? imagem;
  File? get image => _image.value;

  @override
  void onInit() {
    super.onInit();
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

  String? validateParticipants(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório';
    }
    final participants = int.tryParse(value);
    if (participants == null || participants <= 0) {
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


  Future<void> onCadastroProduto() async {
    if (registerProdutoFormKey.currentState?.validate() ?? false) {
      setLoading(true);
      try {
        final double precoBoicoins = double.tryParse(precoBoicoinsController.text) ?? 0;
        final double precoReal = double.tryParse(precoRealController.text) ?? 0;

        print('-------------------------------');
        print(nomeController.text);
        print(descricaoController.text);
        print(precoBoicoins);
        print(precoReal);
        //print(quantidadeEmEstoque);
        print('Imagem --->>>>>${_image.value!.path}');

        final cadastrarProdutoResponse = await produtoRepository.addProduto(
          nome: nomeController.text,
          descricao: descricaoController.text,
          precoBoicoins: precoBoicoins,
          precoReal: precoReal,
          quantidadeEmEstoque: int.tryParse(quantidadeController.text) ?? 20,
          image: imagem!,
        );

        if (cadastrarProdutoResponse['valid']) {
          Get.back();
          return Toast.success(
            'Produto cadastrado com sucesso!',
            'O produto foi adicionado com sucesso.',
            delayed: true,
          );
        } else {
          return Toast.error(
            'Erro ao cadastrar produto',
            cadastrarProdutoResponse['reason'] ?? 'Erro ao cadastrar produto.',
            delayed: true,
          );
        }
      } catch (e) {
        print("Erro ao cadastrar produto: $e");
        Get.snackbar("Erro", "Falha ao cadastrar produto.");
      } finally {
        setLoading(false);
      }
    }
  }
}
