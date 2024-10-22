import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/data/repositories/oficinas/oficinas_repository.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/cadastro_oficina/cadastro_oficina_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/editor_oficina/editor_oficina_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/oficinas_adm_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OficinasAdmController extends BaseController {
  final oficinasRepo = OficinasRepository();
  //RxBool get isLoading => super.isLoading;
  //var isLoading = true.obs;
  List<Oficina> oficinas = <Oficina>[];

  @override
  void onInit() {
    super.onInit();
    getOficinas();
  }

  Future<void> getOficinas() async {
    setLoading(true);

    final response = await oficinasRepo.fetchOficinas();
    final isValid = isValidResponse(response: response, title: response.reason);
    if (isValid && response.data != null) {
      oficinas = response.data;
    }

    setLoading(false);
    update();
  }

  void showDeleteConfirmationDialog(
      BuildContext context, Future<void> Function() onDelete) {
    Get.dialog(
      AlertDialog(
        title: Text('Confirmação'),
        content: Text('Deseja excluir a oficina?',style: TextStyle(
          fontSize: 18.sp
        ),),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); 
            },
            child: Text('Cancelar', style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black
            ),),
          ),
          TextButton(
            onPressed: () async {
              await onDelete();
              Get.back(); 
            },
            child: Text('Confirmar',style: TextStyle(
              fontSize: 16.sp,
              color: Colors.red
            ),),
          ),
        ],
      ),
    );
  }

  void goToEditOficina(Oficina oficina) {
    Get.toNamed(EditorOficinaModule.path, arguments: oficina);
  }

  void onAddOficinasPressed() {
    Get.toNamed(AddOficinaModule.path);
  }

  Future <void> onDeleteOficina(Oficina oficina) async {
    try {

        final registerOficina = await OficinasRepository().deletarOficinas(
          id: oficina.id
        );

        Get.offAllNamed(OficinasAdminModule.path);
      } finally {
        setLoading(false);
      }
  }
}
