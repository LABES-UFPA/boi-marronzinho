import 'package:boi_marronzinho/app/modules/administrador/contas/contas_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/contas/editor_contas/editor_contas_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/eventos/cadastro_evento/cadastro_evento_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/eventos/editor_evento/editor_evento_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/eventos/eventos_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/item_troca/cadastro_item/cadastro_item_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/item_troca/editor_item/editor_item_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/item_troca/item_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/editor_oficina/editor_oficina_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/produtos/cadastro_produto/cadastro_produto_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/produtos/editor_produto/editor_produto_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/produtos/produtos_module.dart';
import 'package:boi_marronzinho/app/modules/cadastro/cadastro_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/admin_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/cadastro_oficina/cadastro_oficina_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/oficinas_adm/oficinas_adm_module.dart';
import 'package:boi_marronzinho/app/modules/administrador/scanner/scanner_module.dart';
import 'package:boi_marronzinho/app/modules/home_page/doacoes/doacoes_module.dart';
import 'package:boi_marronzinho/app/modules/home_page/home_page_module.dart';
import 'package:boi_marronzinho/app/modules/home_page/mapa/localizar_module.dart';
import 'package:boi_marronzinho/app/modules/login/login_module.dart';
import 'package:boi_marronzinho/app/modules/loja/loja_module.dart';
import 'package:boi_marronzinho/app/modules/loja/oficinas/oficinas_module.dart';
import 'package:boi_marronzinho/app/modules/loja/produtos/produtos_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/perfil_module.dart';
import 'package:boi_marronzinho/app/modules/home_page/doacoes/pix/pix_module.dart';
import 'package:boi_marronzinho/app/modules/home_page/sobre_nos/sobrenos_module.dart';
import 'package:boi_marronzinho/app/modules/home_page/eventos/eventos_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/vouchers/voucher/voucher_module.dart';
import 'package:boi_marronzinho/app/modules/splash/splash_module.dart';
import 'package:boi_marronzinho/app/modules/loja/troca/troca_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/vouchers/vouchers_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/meus_dados/meus_dados_module.dart';
import 'package:boi_marronzinho/app/modules/perfil/carteira/carteira_module.dart';

class AppPages {
  AppPages._();

  static final routes = [
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
    EditorOficinaModule.page,
    VoucherModule.page,
    ContasModule.page,
    EditorContaModule.page,
    AddEventoModule.page,
    EventosAdminModule.page,
    AddItemModule.page,
    EditorItemModule.page,
    ItemsAdminModule.page,
    EditorEventoModule.page,
    ProdutosAdminModule.page,
    AddProdutoModule.page,
    ProdutosModule.page,
    EditorProdutoModule.page,
    LocalizarModule.page
  ];
}