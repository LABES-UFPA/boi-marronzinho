import 'dart:io';

import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/repositories/oficinas/oficinas_repository.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/oficinas_adm_module.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddOficinaController extends BaseController {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precoBoicoinsController = TextEditingController();
  final TextEditingController precoReaisController = TextEditingController();
  final TextEditingController participantesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final GlobalKey<FormState> registerOficinaFormKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  //var address = ''.obs;
  var selectDate = DateTime.now().obs;
  var _image = Rxn<File>();
  File? get image => _image.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //getCoordinatesFromAddress('Alameda Santa Fé Quadra 159, Número 14');
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
    }
  }

  Future<void> selectedDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2200));
    if (date != null && date != selectDate.value) {
      selectDate.value = date;
    }
  }

  Future<void> onCadastroOficina() async {
    if (registerOficinaFormKey.currentState?.validate() ?? false) {
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

        Get.offAllNamed(OficinasAdminModule.path);
      } finally {
        setLoading(false);
      }
    }
  }
  Future<String> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        print(location);
        return 'Latitude: ${location.latitude}, Longitude: ${location.longitude}';
      } else {
        return 'Nenhum resultado encontrado para o endereço fornecido.';
      }
    } catch (e) {
      return 'Erro ao buscar coordenadas: $e';
    }
  }

}
