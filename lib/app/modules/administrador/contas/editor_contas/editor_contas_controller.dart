import 'dart:io';
import 'package:boi_marronzinho/app/data/models/user_permissions/user_permission.dart';
import 'package:boi_marronzinho/app/data/repositories/user_permissions/user_permisson_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EditorContaController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController tipoUsuarioController = TextEditingController();
  final GlobalKey<FormState> editContaFormKey = GlobalKey<FormState>();
  late UserPermission conta;
  RxString selectedOption = ''.obs;
  @override
  void onInit() {
    super.onInit();
    // Receber dados da conta que será editada
    conta = Get.arguments as UserPermission;
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

         final updatedConta = await UserPermissionRepository().atualizarPermissaoUsuario(
           id: conta.id,
           novaPermissao: tipoUsuarioController.text,
         );

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
