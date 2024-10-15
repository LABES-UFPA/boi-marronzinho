import 'dart:io';

import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/oficinas_adm_module.dart';
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
  //var address = ''.obs;
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

  

  Future<void> onCadastroOficina() async {
    if (registerOficinaFormKey.currentState?.validate() ?? false) {
      setLoading(true);
      try {
        final register = await RegisterRepository().register(
          firstName: nomeController.text,
          lastName: sobrenomeController.text,
          password: passwordController.text,
          email: emailController.text,
        );

        Get.offAllNamed(OficinasAdminModule.path);
      } finally {
        setLoading(false);
      }
    }
  }
}
