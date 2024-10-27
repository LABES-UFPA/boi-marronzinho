import 'dart:developer';

import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/produto/produto.dart';
import 'package:boi_marronzinho/app/data/repositories/produto/produto_repository.dart';
import 'package:boi_marronzinho/app/data/repositories/profile/profile_repository.dart';
import 'package:boi_marronzinho/app/data/repositories/user_credentials/user_credentials_repository.dart';
import 'package:boi_marronzinho/app/global_ui/components/toast.dart';
import 'package:boi_marronzinho/app/modules/loja/produtos/produtos_module.dart';
import 'package:get/get.dart';

class ItemCarrinho {
  final Produto produto;
  final int quantidade;

  ItemCarrinho({required this.produto, required this.quantidade});

}

class ProdutosController extends BaseController {
  List<Produto> produtos = [];
  RxInt quantidade = 1.obs;
  RxInt saldo = 0.obs;
  RxDouble carrinhoTotalReais = 0.0.obs;
  RxInt carrinhoTotalBoicoins = 0.obs;

  List<ItemCarrinho> carrinho = <ItemCarrinho>[].obs;

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

  void getTotalProdutosCarrinho() {
    double totalReais = 0;
    int totalBoicoins = 0;
    for (var item in carrinho) {
      totalReais += item.produto.precoReal * item.quantidade;
      totalBoicoins += (item.produto.precoBoicoins * item.quantidade).toInt();
    }
    carrinhoTotalReais.value = totalReais;
    carrinhoTotalBoicoins.value = totalBoicoins;
  }

  void resetCarrinho() {
    carrinho.clear();
    carrinhoTotalBoicoins.value = 0;
    carrinhoTotalReais.value = 0;
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

  void removeProdutoFromCarrinho(int index) {
    log('Removendo produto do carrinho');
    carrinho.removeAt(index);
    getTotalProdutosCarrinho();
  }

  // Adiciona um procuto no carrinho
  void addProdutoToCarrinho(Produto produto, int quantidade) {
    // TODO: Verifica se já tem
    carrinho.add(
      ItemCarrinho(produto: produto, quantidade: quantidade)
    );
  }
}
