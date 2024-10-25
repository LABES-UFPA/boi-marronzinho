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
  RxInt quantidade = 1.obs;
  RxInt saldo = 0.obs;
  Map<String, dynamic> carrinho = {
    'produto': Produto(
        id: 'aaaa',
        nome: 'Camisa',
        descricao: 'Camis',
        precoBoicoins: 100,
        precoReal: 100,
        quantidadeEmEstoque: 100,
        imagemURL: 'assets/images/eventos/evento-1.jpg',
        criadoEm: DateTime.now()),
    'quantidade': 10,
  };

  @override
  void onInit() async {
    super.onInit();
    setLoading(true);
    // TODO: Mudar para getProdutos()
    getTesteProdutos();
    await getSaldo();
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

  void resetDescricaoPage() {
    quantidade.value = 1;
  }

  void getTesteProdutos() async {
    produtos = [
      Produto(
          id: 'aaaa',
          nome: 'Camisa',
          descricao: 'Camis',
          precoBoicoins: 100,
          precoReal: 100,
          quantidadeEmEstoque: 100,
          imagemURL: 'assets/images/eventos/evento-1.jpg',
          criadoEm: DateTime.now()),
      Produto(
          id: 'aaaa',
          nome: 'Camisa',
          descricao: 'Camis',
          precoBoicoins: 100,
          precoReal: 100,
          quantidadeEmEstoque: 100,
          imagemURL: 'assets/images/eventos/evento-1.jpg',
          criadoEm: DateTime.now()),
      Produto(
          id: 'aaaa',
          nome: 'Camisa',
          descricao: 'Camis',
          precoBoicoins: 100,
          precoReal: 100,
          quantidadeEmEstoque: 100,
          imagemURL: 'assets/images/eventos/evento-1.jpg',
          criadoEm: DateTime.now()),
      Produto(
          id: 'aaaa',
          nome: 'Camisa',
          descricao: 'Camis',
          precoBoicoins: 100,
          precoReal: 100,
          quantidadeEmEstoque: 100,
          imagemURL: 'assets/images/eventos/evento-1.jpg',
          criadoEm: DateTime.now()),
      Produto(
          id: 'aaaa',
          nome: 'Camisa',
          descricao: 'Camis',
          precoBoicoins: 100,
          precoReal: 100,
          quantidadeEmEstoque: 100,
          imagemURL: 'assets/images/eventos/evento-1.jpg',
          criadoEm: DateTime.now()),
      Produto(
          id: 'aaaa',
          nome: 'Camisa',
          descricao: 'Camis',
          precoBoicoins: 100,
          precoReal: 100,
          quantidadeEmEstoque: 100,
          imagemURL: 'assets/images/eventos/evento-1.jpg',
          criadoEm: DateTime.now()),
      Produto(
          id: 'aaaa',
          nome: 'Camisa',
          descricao: 'Camis',
          precoBoicoins: 100,
          precoReal: 100,
          quantidadeEmEstoque: 100,
          imagemURL: 'assets/images/eventos/evento-1.jpg',
          criadoEm: DateTime.now()),
      Produto(
          id: 'aaaa',
          nome: 'Camisa',
          descricao: 'Camis',
          precoBoicoins: 100,
          precoReal: 100,
          quantidadeEmEstoque: 100,
          imagemURL: 'assets/images/eventos/evento-1.jpg',
          criadoEm: DateTime.now()),
      Produto(
          id: 'aaaa',
          nome: 'Camisa',
          descricao: 'Camis',
          precoBoicoins: 100,
          precoReal: 100,
          quantidadeEmEstoque: 100,
          imagemURL: 'assets/images/eventos/evento-1.jpg',
          criadoEm: DateTime.now()),
    ];
  }

  Future<void> getSaldo() async {
    // TODO: Ver se tem em cache
    final response = await ProfileRepository().getProfileInfo(
        id: UserCredentialsRepository().getCredentials().userId);
    final isValid = isValidResponse(
        response: response, title: 'Sucesso ao pegar saldo de boicoins');
    if (isValid && response.data != null) {
      saldo.value = response.data!.saldoBoicoins.toInt();
    }
  }

  void onMinusPressed() {
    if (quantidade > 1) {
      quantidade -= 1;
    }
  }

  void onPlusPressed() {
    if (quantidade < 99) {
      quantidade += 1;
    }
  }

  Future<void> pagarComBoicoins(Produto produto) async {
    if (produto.precoBoicoins.toInt() * quantidade.value > saldo.value) {
      Get.offAndToNamed(ProdutosModule.path);
      return Toast.error('Erro na Compra', 'Você não tem boicoins suficientes',
          delayed: true);
    }

    final response = await ProdutoRepository().comprarProduto(
        usuarioId: UserCredentialsRepository().getCredentials().userId,
        produtoId: produto.id);

    final isValid = isValidResponse(response: response, title: response.reason);
    if (isValid && response.data != null) {
      Get.offAndToNamed(ProdutosModule.path);
      return Toast.success('Inscrição confirmada!',
          'Você comprou o seu ${produto.nome}! Venha pegar no Boi!');
    }
    Get.offAndToNamed(ProdutosModule.path);
    return Toast.alert(
        'Algo deu errado na sua compra!', 'Chame o administrador!');
  }

  void onFloatingCarrinhoPressed() {}

  void pagarComPix(Produto produto) {}

  void onAddCarrinhoPressed() {}
}
