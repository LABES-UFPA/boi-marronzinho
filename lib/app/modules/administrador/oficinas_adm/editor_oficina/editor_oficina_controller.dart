import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/enumerators/endpoints.enum.dart';
import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/data/util/api/api_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditorOficinaController extends BaseController {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precoBoicoinsController = TextEditingController();
  final TextEditingController precoReaisController = TextEditingController();
  final TextEditingController participantesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final GlobalKey<FormState> editOficinaFormKey2 = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  late Oficina oficina;
  var selectDate = DateTime.now().obs;
  var _image = Rxn<File>();
  File? get image => _image.value;
  File? imagem;
  String url='';
  late ApiHelpers apiHelpers = ApiHelpers();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    oficina = Get.arguments as Oficina;
    nomeController.text = oficina.nomeOficina;
    descricaoController.text = oficina.descricao;
    precoBoicoinsController.text = oficina.precoBoicoin.toString();
    precoReaisController.text = oficina.precoReal.toString();
    participantesController.text = oficina.limiteParticipantes.toString();
    url = ApiHelpers().buildUrl(
      url:oficina.imagem,
      endpoint: Endpoints.MINIO
    );
    print('url ----->>>>>> ${url}');
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

  Future<void> onEditOficina() async {
    if (editOficinaFormKey2.currentState?.validate() ?? false) {
      setLoading(true);
      try {
        double precoBoicoins = double.tryParse(precoBoicoinsController.text) ?? 0.0;
        double precoReais = double.tryParse(precoReaisController.text) ?? 0.0;

        /*final registerOficina = await OficinasRepository().cadastrarOficina(
          nome: nomeController.text,
          descricao: descricaoController.text,
          precoBoicoin: precoBoicoins,
          precoReal: precoReais,
          dataOficina: dateController.text,
          limiteOficina: int.tryParse(participantesController.text) ?? 20,
        );*/

        Get.back();
      } finally {
        setLoading(false);
      }
    }
  }



}
