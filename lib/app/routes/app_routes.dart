<<<<<<< HEAD
import 'package:boi_marronzinho/app/modules/cadastro/cadastro_module.dart';
import 'package:boi_marronzinho/app/modules/carteira/carteira_module.dart';
import 'package:boi_marronzinho/app/modules/doacoes/doacoes_module.dart';
=======
import 'package:boi_marronzinho/app/modules/administrador/admin_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/cadastro_oficina/cadastro_oficina_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/oficinas_adm_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/scanner/scanner_module.dart';

import 'package:boi_marronzinho/app/modules/cadastro/cadastro_module.dart';
import 'package:boi_marronzinho/app/modules/home_page/doacoes/doacoes_module.dart';
>>>>>>> main
import 'package:boi_marronzinho/app/modules/home_page/home_page_module.dart';
import 'package:boi_marronzinho/app/modules/initial/flow_initial/flow_initial_module.dart';
import 'package:boi_marronzinho/app/modules/login/login_module.dart';
import 'package:boi_marronzinho/app/modules/loja/loja_module.dart';
import 'package:boi_marronzinho/app/modules/loja/oficinas/oficinas_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/perfil_module.dart';
import 'package:boi_marronzinho/app/modules/home_page/doacoes/pix/pix_module.dart';
import 'package:boi_marronzinho/app/modules/home_page/sobre_nos/sobrenos_module.dart';
import 'package:boi_marronzinho/app/modules/home_page/eventos/eventos_module.dart';
import 'package:boi_marronzinho/app/modules/splash/splash_module.dart';
import 'package:boi_marronzinho/app/modules/loja/troca/troca_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/vouchers/vouchers_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/meus_dados/meus_dados_module.dart';

class AppPages {
  AppPages._();

  static final routes = [
    FlowInitialModule.page,
    HomeModule.page,
    EventosModule.page,
    DoacoesModule.page,
    SobreNosModule.page,
    LoginModule.page,
    CadastroModule.page,
    SplashModule.page,
    LojaModule.page,
    PerfilModule.page,
    TrocaModule.page,
    PixModule.page,
    VouchersModule.page,
    CarteiraModule.page,
    OficinasModule.page,
    AdminModule.page,
    OficinasAdminModule.page,
    AddOficinaModule.page,
    ScannerModule.page,
    MeusDadosModule.page,
  ];
}
