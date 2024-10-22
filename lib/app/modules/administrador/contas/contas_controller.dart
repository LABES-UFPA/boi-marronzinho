import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/profile/profile.dart';
import 'package:boi_marronzinho/app/data/models/user_permission/user_permission.dart';
import 'package:boi_marronzinho/app/data/repositories/profile/profile_repository.dart';
import 'package:boi_marronzinho/app/modules/administrador/contas/editor_contas/editor_contas_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContasController extends BaseController {
  final contasRepo = ProfileRepository();
  TextEditingController searchController = TextEditingController();
  //RxBool get isLoading => super.isLoading;
  //var isLoading = true.obs;
  List<UserPermission> contas = <UserPermission>[];

  @override
  void onInit() {
    super.onInit();
    getContasTeste();
  }

  Future<void> getContas() async {
    setLoading(true);

    //final response = await contasRepo.fetchContas();
    /*

    final isValid = isValidResponse(response: response, title: 'Ovo Frito');
    if (isValid && response.data != null) {
      contas = response.data;
    }

    */

    setLoading(false);
    update();
  }

  Future<void> getContasTeste() async {
    setLoading(true);

    // Simulação de contas
    final List<UserPermission> contasSimuladas = [
      UserPermission(
        id: '1',
        firstName: 'João',
        lastName: 'Silva',
        email: 'joao.silva@example.com',
        tipoUsuario: 'Administrador', 
      ),
      UserPermission(
        id: '2',
        firstName: 'Maria',
        lastName: 'Oliveira',
        email: 'maria.oliveira@example.com',
        tipoUsuario: 'Usuário',
      ),
      UserPermission(
        id: '3',
        firstName: 'Roberto',
        lastName: 'Oliveira',
        email: 'maria.oliveira@example.com',
        tipoUsuario: 'Usuário', 
      ),
    ];

    // Simula um atraso de 2 segundos
    await Future.delayed(Duration(seconds: 2));

    // Atribuindo a lista simulada à variável da classe
    contas = contasSimuladas; // Atualize esta linha

    setLoading(false);
    update();
  }

  void showDeleteConfirmationDialog(
      BuildContext context, Future<void> Function() onDelete) {
    Get.dialog(
      AlertDialog(
        title: Text('Confirmação'),
        content: Text(
          'Deseja excluir a conta?',
          style: TextStyle(fontSize: 18.sp),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Cancelar',
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () async {
              await onDelete();
              Get.back();
            },
            child: Text(
              'Confirmar',
              style: TextStyle(fontSize: 16.sp, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void goToEditConta(UserPermission conta) {
    Get.toNamed(EditorContaModule.path, arguments: conta);
  }

  // void onAddContasPressed() {
  //   Get.toNamed(AddContaModule.path);
  // }

  Future<void> onDeleteConta(UserPermission conta) async {
    try {
      //final registerConta = await ProfileRepository().deletarProfile(id: conta.id);

      update();
      //Get.offAllNamed(ContasModule.path);
    } finally {
      setLoading(false);
    }
  }
}
