import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/user_permissions/user_permission.dart';
import 'package:boi_marronzinho/app/data/repositories/user_permissions/user_permisson_repository.dart';
import 'package:boi_marronzinho/app/modules/administrador/contas/editor_contas/editor_contas_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContasController extends BaseController {
  final contasRepo = UserPermissionRepository();
  TextEditingController searchController = TextEditingController();
  //RxBool get isLoading => super.isLoading;
  //var isLoading = true.obs;
  List<UserPermission> contas = <UserPermission>[];

  @override
  void onInit() {
    super.onInit();
    getContas();
  }

  Future<void> getContas() async {
    setLoading(true);



    final response = await contasRepo.fetchAllUsers();

    final isValid = isValidResponse(response: response, title: response.reason);
    if (isValid && response.data != null) {
      contas = response.data;
    }


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
      final deleteConta = await UserPermissionRepository().deleteUser(id: conta.id);

      update();
      //Get.offAllNamed(ContasModule.path);
    } finally {
      setLoading(false);
    }
  }
}
