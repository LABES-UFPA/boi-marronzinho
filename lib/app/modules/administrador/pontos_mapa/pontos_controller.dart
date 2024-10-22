import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PontosAdmController extends BaseController {
  // final pontosRepo = PontosRepository();
    List<Ponto> pontos = <Ponto>[];

  get onAddPontosPressed => null;

  void goToEditPonto(Ponto ponto) {}

  void showDeleteConfirmationDialog(BuildContext context, Future<Null> Function() param1) {}

  onDeletePonto(Ponto ponto) {}

  // @override
  // void onInit() {
  //   super.onInit();
  //   getPontos();
  // }

  // Future<void> getPontos() async {
  //   setLoading(true);

  //   final response = await pontosRepo.fetchPontos();
  //   final isValid = isValidResponse(response: response, title: 'Ovo Frito');
  //   if (isValid && response.data != null) {
  //     pontos = response.data;
  //   }

  //   setLoading(false);
  //   update();
  // }

  // void showDeleteConfirmationDialog(
  //     BuildContext context, Future<void> Function() onDelete) {
  //   Get.dialog(
  //     AlertDialog(
  //       title: Text('Confirmação'),
  //       content: Text('Deseja excluir o ponto?', style: TextStyle(
  //         fontSize: 18.sp
  //       )),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Get.back(); 
  //           },
  //           child: Text('Cancelar', style: TextStyle(
  //             fontSize: 16.sp,
  //             color: Colors.black
  //           )),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             await onDelete();
  //             Get.back(); 
  //           },
  //           child: Text('Confirmar', style: TextStyle(
  //             fontSize: 16.sp,
  //             color: Colors.red
  //           )),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void goToEditPonto(Ponto ponto) {
  //   Get.toNamed(EditorPontoModule.path, arguments: ponto);
  // }

  // void onAddPontosPressed() {
  //   Get.toNamed(AddPontoModule.path);
  // }

  // Future<void> onDeletePonto(Ponto ponto) async {
  //   try {
  //     final registerPonto = await PontosRepository().deletarPontos(
  //       id: ponto.id
  //     );
  //     update();
  //   } finally {
  //     setLoading(false);
  //   }
  // }
}

class Ponto {
  get nomePonto => null;
}
