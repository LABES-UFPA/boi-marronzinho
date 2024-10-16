import 'package:boi_marronzinho/app/modules/home_page/eventos/eventos_binding.dart';
import 'package:boi_marronzinho/app/modules/home_page/eventos/eventos_view.dart';
import 'package:get/get.dart';

abstract class EventosModule {
  static const path = '/eventos';

  static GetPage page = GetPage(
      name: path, page: () => const EventosView(), binding: EventosBinding());
}
