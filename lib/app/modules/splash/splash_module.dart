import 'package:boi_marronzinho/app/modules/splash/splash_binding.dart';
import 'package:boi_marronzinho/app/modules/splash/splash_view.dart';
import 'package:get/get.dart';

abstract class SplashModule {
  static const path = '/';

  static GetPage page = GetPage(
    name: path,
    page: () => SplashView(),
    binding: SplashBinding(),
  );
}