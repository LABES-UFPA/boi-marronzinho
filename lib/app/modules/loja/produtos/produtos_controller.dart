import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/produto/produto.dart';
import 'package:boi_marronzinho/app/data/repositories/produto/produto_repository.dart';
import 'package:boi_marronzinho/app/data/repositories/profile/profile_repository.dart';
import 'package:boi_marronzinho/app/data/repositories/user_credentials/user_credentials_repository.dart';
import 'package:boi_marronzinho/app/global_ui/components/toast.dart';
import 'package:boi_marronzinho/app/modules/loja/produtos/produtos_module.dart';
import 'package:get/get.dart';

class ProdutosController extends BaseController {

  List<Produto> produtos = [];
  RxInt quantidade = 0.obs;
  RxInt saldo = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    setLoading(true);
    // TODO: Mudar para getProdutos()
    getTesteProdutos();
    setLoading(false);
    update();
  }

  void getProdutos() async {
    final response = await ProdutoRepository().fetchProdutos();
    final isValid = isValidResponse(response: response, title: response.reason);
    if (isValid && response.data != null) {
      produtos = response.data;
    }
  }

  void getTesteProdutos() async {
    produtos = [
      Produto(id: 'aaaa', nome: 'Camisa', descricao: 'Camis', precoBoicoins: 100, precoReal: 100, quantidadeEmEstoque: 100, imagemURL: 'assets/images/eventos/evento-1.jpg', criadoEm: DateTime.now()),
      Produto(id: 'aaaa', nome: 'Camisa', descricao: 'Camis', precoBoicoins: 100, precoReal: 100, quantidadeEmEstoque: 100, imagemURL: 'assets/images/eventos/evento-1.jpg', criadoEm: DateTime.now()),
      Produto(id: 'aaaa', nome: 'Camisa', descricao: 'Camis', precoBoicoins: 100, precoReal: 100, quantidadeEmEstoque: 100, imagemURL: 'assets/images/eventos/evento-1.jpg', criadoEm: DateTime.now()),
      Produto(id: 'aaaa', nome: 'Camisa', descricao: 'Camis', precoBoicoins: 100, precoReal: 100, quantidadeEmEstoque: 100, imagemURL: 'assets/images/eventos/evento-1.jpg', criadoEm: DateTime.now()),
      Produto(id: 'aaaa', nome: 'Camisa', descricao: 'Camis', precoBoicoins: 100, precoReal: 100, quantidadeEmEstoque: 100, imagemURL: 'assets/images/eventos/evento-1.jpg', criadoEm: DateTime.now()),
    ];
  }

  Future<void> getSaldo() async {
    // TODO: Ver se tem em cache
    final response = await ProfileRepository().getProfileInfo(id: UserCredentialsRepository().getCredentials().userId);
    final isValid = isValidResponse(response: response, title: 'Sucesso ao pegar saldo de boicoins');
    if (isValid && response.data != null) {
      saldo.value = response.data!.saldoBoicoins.toInt();
    }
  }

  void onMinusPressed() {
    if (quantidade > 0) {
      quantidade -= 1;
    }
  }

  void onPlusPressed() {
    if (quantidade < 99) {
      quantidade += 1;
    }
  }

  Future<void> pagarComBoicoins(Produto produto) async {
    if (produto.precoBoicoin.toInt() > saldo) {
      Get.offAndToNamed(ProdutosModule.path);
      return Toast.error(
          'Erro na Compra',
          'Você não tem boicoins suficientes',
          delayed: true
      );
    }

    final response = await ProdutoRepository().comprarProduto(
        usuarioId: UserCredentialsRepository().getCredentials().userId,
        oficinaId: oficina.id
    );

    final isValid = isValidResponse(response: response, title: response.reason);
    if (isValid && response.data != null) {
      Get.offAndToNamed(ProdutosModule.path);
      return Toast.success(
          'Inscrição confirmada!',
          'Você se inscreveu na oficina ${oficina.nomeOficina}! Te esperamos lá!'
      );
    }
    Get.offAndToNamed(ProdutosModule.path);
    return Toast.alert('Você já está inscrito!', 'Você já se inscreveu nesta oficina!');
  }



  void pagarComPix(Produto produto) {

  }

  void onCarrinhoPressed() {

  }

}
