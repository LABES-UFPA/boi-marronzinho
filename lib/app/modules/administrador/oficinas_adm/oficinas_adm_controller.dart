import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/oficinas_response/oficinas_response.dart';
import 'package:boi_marronzinho/app/data/repositories/oficinas/oficinas_repository.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/cadastro_oficina/cadastro_oficina_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/editor_oficina/editor_oficina_module.dart';
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
    final isValid = isValidResponse(response: response, title: 'Ovo Frito');
    if (isValid && response.data != null) {
      oficinas = response.data;
    }

    setLoading(false);
    update();
  }

  void showDeleteConfirmationDialog(
      BuildContext context, Future<void> Function() onConfirm) {
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
              await onConfirm(); 
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

  Future<void> onDeleteOficina(Oficina oficina) async {
    print(oficina.nomeOficina);
    print(oficina.id);
    /*if (editOficinaFormKey.currentState?.validate() ?? false) {
      setLoading(true);
      try {
        double precoBoicoins = double.tryParse(precoBoicoinsController.text) ?? 0.0;
        double precoReais = double.tryParse(precoReaisController.text) ?? 0.0;

        final registerOficina = await OficinasRepository().cadastrarOficina(
          nome: nomeController.text,
          descricao: descricaoController.text,
          precoBoicoin: precoBoicoins,
          precoReal: precoReais,
          dataOficina: dateController.text,
          limiteOficina: int.tryParse(participantesController.text) ?? 20,
        );

        Get.offAllNamed(OficinasAdminModule.path);
      } finally {
        setLoading(false);
      }
    }*/
  }

  void onAddOficinasPressed() {
    Get.toNamed(AddOficinaModule.path);
  }
}
