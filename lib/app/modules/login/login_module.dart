import 'package:boi_marronzinho/app/modules/login/login_binding.dart';
import 'package:boi_marronzinho/app/modules/login/login_view.dart';
import 'package:get/get.dart';

abstract class LoginModule {
  static const path = '/login';

  static GetPage page = GetPage(
    name: path,
    page: () => LoginView(),
    binding: LoginBinding(),
  );
}
