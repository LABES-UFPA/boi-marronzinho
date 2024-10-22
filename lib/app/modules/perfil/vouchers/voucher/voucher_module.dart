import 'package:boi_marronzinho/app/modules/perfil/vouchers/voucher/voucher_binding.dart';
import 'package:boi_marronzinho/app/modules/perfil/vouchers/voucher/voucher_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class VoucherModule {
  static const path = '/voucher';

  static GetPage page = GetPage(
    name: path,
    page: () =>  VoucherView(),
    binding: VoucherBinding(),
  );
}