import 'dart:developer';

import 'package:boi_marronzinho/app/data/controllers/base_controller.dart';
import 'package:boi_marronzinho/app/data/models/produto/carrinho.dart';
import 'package:boi_marronzinho/app/data/models/produto/produto.dart';
import 'package:boi_marronzinho/app/data/repositories/produto/produto_repository.dart';
import 'package:boi_marronzinho/app/data/repositories/profile/profile_repository.dart';
import 'package:boi_marronzinho/app/data/repositories/user_credentials/user_credentials_repository.dart';
import 'package:boi_marronzinho/app/data/util/api/api_helpers.dart';
import 'package:boi_marronzinho/app/global_ui/components/toast.dart';
import 'package:boi_marronzinho/app/modules/loja/produtos/produtos_module.dart';
import 'package:get/get.dart';

class ItemCarrinho {
  final Produto produto;
  final Carrinho? carrinho;
  int quantidade;

  ItemCarrinho({this.carrinho, required this.produto, required this.quantidade});

}

class ProdutosController extends BaseController {
  late ApiHelpers apiHelpers = ApiHelpers();
  List<Produto> produtos = [];
  RxInt quantidade = 1.obs;
  RxInt saldo = 0.obs;
  RxDouble carrinhoTotalReais = 0.0.obs;
  RxInt carrinhoTotalBoicoins = 0.obs;

  List<ItemCarrinho> carrinho = <ItemCarrinho>[].obs;
  List<int> carrinhoQuantidades = <int>[].obs;

  @override
  void onInit() async {
    super.onInit();
    setLoading(true);
    await getProdutos();
    await getSaldo();
    setLoading(false);
    update();
  }

  Future<void> getProdutos() async {
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
    carrinhoQuantidades.clear();
    carrinhoTotalBoicoins.value = 0;
    carrinhoTotalReais.value = 0;
  }

  void resetDescricaoPage() {
    quantidade.value = 1;
  }

  Future<void> getSaldo() async {
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

  void onItemCarrinhoPlusPressed(int indexOnCarrinho) {
    if (carrinhoQuantidades[indexOnCarrinho] >= 99) {
      return;
    }

    carrinho[indexOnCarrinho].quantidade += 1;
    carrinhoQuantidades[indexOnCarrinho] += 1;
    ProdutoRepository().atualizarQuantidadeCarrinhoProduto(
      produtoId: carrinho[indexOnCarrinho].produto.id,
      quantidade: carrinhoQuantidades[indexOnCarrinho],
      usuarioId: UserCredentialsRepository().getCredentials().userId,
    );
    getTotalProdutosCarrinho();
  }

  void onItemCarrinhoMinusPressed(int indexOnCarrinho) {
    if (carrinhoQuantidades[indexOnCarrinho] == 1) {
      return;
    }
    carrinhoQuantidades[indexOnCarrinho] -= 1;
    carrinho[indexOnCarrinho].quantidade -= 1;
    ProdutoRepository().atualizarQuantidadeCarrinhoProduto(
      produtoId: carrinho[indexOnCarrinho].produto.id,
      quantidade: carrinhoQuantidades[indexOnCarrinho],
      usuarioId: UserCredentialsRepository().getCredentials().userId,
    );
    getTotalProdutosCarrinho();
  }

  void onFloatingCarrinhoPressed() async {
    await getCarrinho();
  }

  void pagarComPix(Produto produto) {}

  Produto searchProdutoById(String id) {
    for (var p in produtos) {
      if (p.id == id) {
        return p;
      }
    }
    throw Exception('Id não existe!');
  }

  Future<void> getCarrinho() async {
    setLoading(true);
    carrinho.clear();
    final response = await ProdutoRepository().getCarrinho(usuarioId: UserCredentialsRepository().getCredentials().userId);
    final isValid = isValidResponse(response: response, title: response.reason);
    if (isValid && response.data != null) {
      for (var item in response.data) {
        carrinho.add(ItemCarrinho(produto: searchProdutoById(item.produtoId), quantidade: item.quantidade, carrinho: item));
        carrinhoQuantidades.add(item.quantidade);
      }
    }
    setLoading(false);
    update();
  }

  void removeProdutoFromCarrinho(int index) {
    log('Removendo produto do carrinho');
    ProdutoRepository().removeItemCarrinho(usuarioId: UserCredentialsRepository().getCredentials().userId, itemId: carrinho[index].carrinho!.id);
    carrinho.removeAt(index);
    getTotalProdutosCarrinho();
  }

  // Adiciona um procuto no carrinho
  Future<void> addProdutoToCarrinho(Produto produto, int quantidade) async {
    final response = await ProdutoRepository().addItemCarrinho(
      usuarioId: UserCredentialsRepository().getCredentials().userId,
      produtoId: produto.id,
      quantidade: quantidade
    );
    final isValid = isValidResponse(response: response, title: response.reason);
    if (!isValid) {
      return Toast.error('Erro ao adicionar ao carrinho', 'Tente novamente mais tarde');
    }
  }

  Future<void> onBoicoinsPressed() async  {
    final response = await ProdutoRepository().finalizarCompra(usuarioId: UserCredentialsRepository().getCredentials().userId);
    if (isValidResponse(response: response, title: response.reason)) {
      resetCarrinho();
      Get.until((route) => route.settings.name == ProdutosModule.path);
      return Toast.success('Compra realizada com sucesso!', 'Fale conosco para retirar seu produto');
    }
  }

  Future<bool> onAdicionarAoCarrinhoPressed(Produto produto, int quantidade) async {
    try {
      await addProdutoToCarrinho(produto, quantidade);
      resetDescricaoPage();
      await getCarrinho();
      getTotalProdutosCarrinho();
      return true;
    } catch (e, _){
      return false;
    }
  }

}
