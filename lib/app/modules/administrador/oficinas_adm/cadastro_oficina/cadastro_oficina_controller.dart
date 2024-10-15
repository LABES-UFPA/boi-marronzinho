import 'dart:io';

import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:flutter/material.dart';
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
  var address = ''.obs;
  var selectDate = DateTime.now().obs;
  var _image = Rxn<File>();
  File? get image => _image.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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

  //função pra pegar o endereço, latitude e longitude
  Future<void> onCadastroOficina() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      //_image = File(pickedFile.path);
    } else {
      _image.value = null;
    }
  }

  void updatelocation(String newAdress, double latitude, double longitude){
    address.value = newAdress;
    enderecoController.text = newAdress;
    latitudeController.text = latitude.toString();
    longitudeController.text = longitude.toString();
  }
}
