import 'dart:io';
import 'package:boi_marronzinho/app/data/models/user_permission/user_permission.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditorContaController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController tipoUsuarioController = TextEditingController();
  final GlobalKey<FormState> editContaFormKey = GlobalKey<FormState>();
  RxString selectedOption = ''.obs;
  @override
  void onInit() {
    super.onInit();
    // Receber dados da conta que será editada
    UserPermission conta = Get.arguments as UserPermission;
    firstNameController.text = conta.firstName;
    lastNameController.text = conta.lastName;
    emailController.text = conta.email;
    tipoUsuarioController.text = conta.tipoUsuario;
  }

  String? validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obrigatório';
    }
    return null;
  }


  Future<void> onEditConta() async {
    if (editContaFormKey.currentState?.validate() ?? false) {
      setLoading(true);
      try {
        // Aqui você pode fazer a requisição para atualizar a conta
        // final updatedConta = await UserRepository().updateUser(
        //   firstName: firstNameController.text,
        //   lastName: lastNameController.text,
        //   email: emailController.text,
        //   tipoUsuario: tipoUsuarioController.text,
        //   image: image, // se necessário
        // );

        Get.back(); // Redirecionar após edição
      } finally {
        setLoading(false);
      }
    }
  }
  
  void setLoading(bool loading) {
    // Implementar lógica para mostrar/ocultar carregando
    // Ex: loading.value = loading;
  }
}
