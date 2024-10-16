import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/oficinas_adm_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/oficinas_adm_view.dart';
import 'package:boi_marronzinho/app/modules/administrador/scanner/scanner_binding.dart';
import 'package:boi_marronzinho/app/modules/administrador/scanner/scanner_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class ScannerModule {
  static const path = '/scanner';

  static GetPage page = GetPage(
    name: path,
    page: () =>  ScannerView(),
    binding: ScannerBinding(),
  );
}