import 'package:boi_marronzinho/app/modules/doacoes/pix/pix_binding.dart';
import 'package:boi_marronzinho/app/modules/doacoes/pix/pix_view.dart';
import 'package:get/get.dart';

abstract class PixModule {
  static const path = '/pix';

  static GetPage page = GetPage(
    name: path,
    page: () =>  PixView(),
    binding: PixBinding(),
  );
}
