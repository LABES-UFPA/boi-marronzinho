import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';

class OficinasAdmController extends BaseController{
  //final voucherRepo = OficinasRepository();
  //RxBool get isLoading => super.isLoading;
  //var isLoading = true.obs;
 // List<Voucher> vouchers = <Voucher>[];

  @override
  void onInit() {
    super.onInit();
    //getVouchers();
  }

  bool getOficinas(){
    bool teste = false;
    return teste;
  }
  /*
  Future<void> getVouchers() async {
    setLoading(true); // Você pode ter uma função para mostrar um loader.

    final response = await voucherRepo.fetchVouchers();
    final isValid = isValidResponse(response: response, title: 'Ovo Frito');
    if (isValid && response.data != null) {
      vouchers = response.data;
    }

    setLoading(false); // Finaliza o loader aqui.
    update(); // Atualiza a interface do GetX.
  }*/
  
}