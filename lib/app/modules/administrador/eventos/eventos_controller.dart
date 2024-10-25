import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/evento/evento.dart';
import 'package:boi_marronzinho/app/data/repositories/evento/evento_repository.dart';
import 'package:boi_marronzinho/app/modules/administrador/eventos/cadastro_evento/cadastro_evento_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/eventos/editor_evento/editor_evento_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EventosAdmController extends BaseController {
  final eventosRepo = EventosRepository();
  List<Evento> eventos = <Evento>[];

  @override
  void onInit() {
    super.onInit();
    getEventos();
  }

  Future<void> getEventos() async {
    setLoading(true);

    final response = await eventosRepo.fetchEventos();
    final isValid = isValidResponse(response: response, title: 'Sucesso ao carregar a lista');
    if (isValid && response.data != null) {
      eventos = response.data;
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
          'Deseja excluir o evento?',
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

  void goToEditEvento(Evento evento) {
    Get.toNamed(EditorEventoModule.path, arguments: evento);
  }

  void onAddEventosPressed() {
    Get.toNamed(AddEventoModule.path);
  }

  Future<void> onDeleteEvento(Evento evento) async {
    try {
      final registerEvento = await eventosRepo.deletarEvento(
        id: evento.id,
      );
      update();
    } finally {
      setLoading(false);
    }
  }
}
