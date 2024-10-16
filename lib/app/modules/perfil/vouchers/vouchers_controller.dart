import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/voucher_response/voucher_response.dart';
import 'package:boi_marronzinho/app/data/repositories/voucher/voucher_repository.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class VouchersController extends BaseController {
  final voucherRepo = VoucherRepository();
  //RxBool get isLoading => super.isLoading;
  //var isLoading = true.obs;
  List<Voucher> vouchers = <Voucher>[];

  @override
  void onInit() {
    super.onInit();
    getVouchers();
  }

  Future<void> getVouchers() async {
    setLoading(true);

    final response = await voucherRepo.fetchVouchers();
    final isValid = isValidResponse(response: response, title: 'Ovo Frito');
    if (isValid && response.data != null) {
      vouchers = response.data;
    }

    setLoading(false);
    update(); 
  }
  
}