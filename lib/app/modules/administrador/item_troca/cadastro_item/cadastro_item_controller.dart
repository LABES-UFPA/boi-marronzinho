import 'dart:io';
import 'dart:convert';
import 'package:boi_marronzinho/app/data/models/troca/item_troca.dart';
import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/repositories/troca/troca_reposity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddItemController extends BaseController {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController unidadeController = TextEditingController();
  final TextEditingController boicoinsController = TextEditingController();
  final GlobalKey<FormState> registerItemFormKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  var _image = Rxn<File>();
  RxString selectedOption = ''.obs;
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

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
      imagem = File(pickedFile.path);
    }
  }

  Future<void> onCadastroItem() async {
    if (registerItemFormKey.currentState?.validate() ?? false) {
      setLoading(true);
      try {
        double boicoinsPorUnidade =
            double.tryParse(boicoinsController.text) ?? 0.0;

        // Chamando o método de cadastro sem imagem
        final response = await TrocaReposity().addItensTroca(
          nome: nomeController.text,
          descricao: descricaoController.text,
          unidadeMedida: unidadeController.text,
          boicoinsPorUnidade: boicoinsPorUnidade,
        );
        if (response.valid) {
          Get.back();
        } else {
          print("Erro ao cadastrar item: ${response.reason}");
        }
      } catch (e) {
        print("Erro ao cadastrar item: $e");
      } finally {
        setLoading(false);
      }
    }
  }
}
