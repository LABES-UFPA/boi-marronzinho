
import 'package:boi_marronzinho/app/modules/doacoes/doacoes_module.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_module.dart';
import 'package:boi_marronzinho/app/modules/initial/flow_initial/flow_initial_module.dart';
import 'package:boi_marronzinho/app/modules/sobre_nos/sobrenos_module.dart';

class AppPages {
  AppPages._();

  static final routes = [
    FlowInitialModule.page,
    HomeModule.page,
    DoacoesModule.page,
    SobreNosModule.page,
  ];
}
