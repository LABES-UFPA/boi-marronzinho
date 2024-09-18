import 'package:boi_marronzinho/app/modules/home_page/home_page_binding.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_view.dart';
import 'package:get/get.dart';

abstract class HomeModule {
  static const path = '/home';

  static GetPage page = GetPage(
    name: path,
    page: () =>  HomePageView(),
    binding: HomePageBinding(),
  );
}
