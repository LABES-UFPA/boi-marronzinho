import 'dart:developer';
import 'package:boi_marronzinho/app/data/models/produto/carrinho.dart';
import 'package:boi_marronzinho/app/data/models/produto/produto.dart';
import 'package:boi_marronzinho/app/data/repositories/produto/produto_repository.interface.dart';
import 'package:boi_marronzinho/app/data/enumerators/endpoints.enum.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';

final class ProdutoRepository extends RequestRepository
    implements IProdutosRepository {
  static const String todosProdutosUrl = '/lojas/todos-produtos';

  // Administrador
  static const String adicionarProdutoUrl = '/lojas/adiciona-produto';
  static const String removerProdutoUrl = '/lojas/remove-produto/';
  static const String atualizarProdutoUrl = '/lojas/atualiza-produto/';

  // Carrinho
  static const String carrinhoUrl = '/lojas/carrinho/';
  static const String carrinhoAdicionarItemUrl = '/lojas/carrinho/adiciona-item/';
  static const String carrinhoRemoverItemUrl = '/lojas/carrinho/remove-item/';
  static const String finalizarCompraUrl = '/lojas/compra/finalizar/';

  // late final CachedRequest _cache;

  @override
  Future fetchProdutos() async {
    final url = apiHelpers.buildUrl(
        url: todosProdutosUrl, endpoint: Endpoints.BOI_MARRONZINHO);

    try {
      final response = await client.get(url);

      final invalidResponse = isValidResponse<List<Produto>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      // await _cache.cacheRequest(response.data);

      final produtos = List.from(response.data)
          .map((item) => Produto.fromMap(item))
          .toList();

      return (
        valid: true,
        reason: 'Sucesso ao pegar todos os produtos da API',
        data: produtos
      );
    } catch (e, stackTrace) {
      log('Error fetching oficinas', error: e, stackTrace: stackTrace);
      return (
        valid: false,
        reason: 'Erro interno durante a requisição',
        data: null
      );
    }
  }

  // Usuário


  @override
  Future getCarrinho({required String usuarioId}) async {
    final url = apiHelpers.buildUrl(
        url: carrinhoUrl + usuarioId, endpoint: Endpoints.BOI_MARRONZINHO);

    try {
      final response = await client.get(url);

      final invalidResponse = isValidResponse<List<Produto>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      // await _cache.cacheRequest(response.data);

      final itens = List.from(response.data)
          .map((item) => Carrinho.fromMap(item))
          .toList();

      return (
      valid: true,
      reason: 'Sucesso ao pegar todos os itens do Carrinho da API',
      data: itens
      );
    } catch (e, stackTrace) {
      log('Error fetching oficinas', error: e, stackTrace: stackTrace);
      return (
      valid: false,
      reason: 'Erro interno durante a requisição',
      data: null
      );
    }
  }

  @override
  Future addItemCarrinho({required String usuarioId, required String produtoId, required int quantidade}) async {
    final url = apiHelpers.buildUrl(
        url: carrinhoAdicionarItemUrl + usuarioId, endpoint: Endpoints.BOI_MARRONZINHO);
    final bodyRequest = {
      'produtoId': produtoId,
      'quantidade': quantidade
    };

    try {
      final response = await client.post(url, bodyRequest);

      final invalidResponse = isValidResponse<List<Produto>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      // await _cache.cacheRequest(response.data);

      final message = response.data;

      return (
        valid: true,
        reason: 'Sucesso ao adicionar item no carrinho',
        data: message
      );
    } catch (e, stackTrace) {
      log('Error adding item to carrinho', error: e, stackTrace: stackTrace);
      return (
        valid: false,
        reason: 'Erro interno durante a requisição',
        data: null
      );
    }
  }

  @override
  Future removeItemCarrinho (
      {required String usuarioId, required String itemId}) async {
    final url = apiHelpers.buildUrl(
        url: carrinhoRemoverItemUrl + itemId + '/' + usuarioId, endpoint: Endpoints.BOI_MARRONZINHO);

    final bodyRequest = {};
    try {
      final response = await client.delete(url, bodyRequest);

      final invalidResponse = isValidResponse<List<Produto>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      // await _cache.cacheRequest(response.data);

      final message = response.data;

      return (
      valid: true,
      reason: 'Sucesso ao remover item do Carrinho na API',
      data: message
      );
    } catch (e, stackTrace) {
      log('Error deleting itens from Carrinho', error: e, stackTrace: stackTrace);
      return (
      valid: false,
      reason: 'Erro interno durante a requisição',
      data: null
      );
    }
  }


  @override
  Future finalizarCompra({required String usuarioId}) async {
    final url = apiHelpers.buildUrl(
        url: finalizarCompraUrl + usuarioId, endpoint: Endpoints.BOI_MARRONZINHO);

    final bodyRequest = {};

    try {
      final response = await client.post(url, bodyRequest);

      final invalidResponse = isValidResponse<List<Produto>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      return (
      valid: true,
      reason: 'Sucesso ao finalizar sua compra!',
      data: 'Compra finalizada');
    } catch (e, stackTrace) {
      log('Error ', error: e, stackTrace: stackTrace);
      return (
      valid: false,
      reason: 'Erro interno durante a requisição',
      data: e
      );
    }
  }

  // Administrador

  @override
  Future addProduto() {
    // TODO: implement addProduto
    throw UnimplementedError();
  }

  @override
  Future removeProduto({required String produtoId}) {
    // TODO: implement removeProduto
    throw UnimplementedError();
  }

  @override
  Future atualizaProduto({required String produtoId}) {
    // TODO: implement atualizaProduto
    throw UnimplementedError();
  }
}
