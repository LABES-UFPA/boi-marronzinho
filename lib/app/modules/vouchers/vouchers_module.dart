import 'package:boi_marronzinho/app/modules/vouchers/vouchers_binding.dart';
import 'package:boi_marronzinho/app/modules/vouchers/vouchers_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class VouchersModule {
  static const path = '/vouchers';

  static GetPage page = GetPage(
    name: path,
    page: () =>  VouchersView(),
    binding: VouchersBinding(),
  );
}