

import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'package:boi_marronzinho/app/data/util/helpers/index.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BaseController extends GetxController {
  final Helpers helpers = Helpers();
  final isLoading = true.obs;

  void setLoading(bool status) => isLoading.value = status;

  void backPage() {
    Get.back();
  }

  // void openUser() {
  //   Get.toNamed(UserProfileModule.path);
  // }

  bool isValidResponse({required ValidResponse response, required String title, void Function()? action}) {
    if (response.valid && response.data != null) {
      return true;
    }

    if (action != null) {
      action();
    }

    // Toast.error(
    //   response.reason == '401' ? 'Sessão expirada!' : title,
    //   response.reason == '401' ? 'Sua sessão foi expirada, efetue seu login novamente' : response.reason!,
    //   delayed: true,
    // );

    setLoading(false);
    return false;
  }
}
