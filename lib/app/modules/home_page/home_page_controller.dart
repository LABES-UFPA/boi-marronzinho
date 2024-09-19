import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_module.dart';
import 'package:get/get.dart';

class HomePageController extends BaseController {

  @override
  void onInit() {
    super.onInit();

    getBoiCoins();
  }


  void onEventosPressed() {
    Get.toNamed(HomeModule.path);
  }

  void onMapaPressed() {
    Get.toNamed(HomeModule.path);
  }

  void onSobreNosPressed() {
    Get.toNamed(HomeModule.path);
  }

  void onDoeAgoraPressed() {
    Get.toNamed(HomeModule.path);
  }


  Future<double> getBoiCoins() async {
    return 0.1;
  }

}
