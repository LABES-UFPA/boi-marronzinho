import 'package:boi_marronzinho/app/modules/administrador/admin_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/admin_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class AdminModule {
  static const path = '/admin';

  static GetPage page = GetPage(
    name: path,
    page: () =>  AdminView(),
    binding: AdminBinding(),
  );
}