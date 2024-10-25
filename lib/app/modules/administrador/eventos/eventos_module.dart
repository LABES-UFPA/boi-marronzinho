import 'package:boi_marronzinho/app/modules/administrador/eventos/eventos_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/eventos/eventos_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class EventosAdminModule {
  static const path = '/eventosadmin';

  static GetPage page = GetPage(
    name: path,
    page: () => EventosAdmView(),
    binding: EventosAdmBinding(),
  );
}
