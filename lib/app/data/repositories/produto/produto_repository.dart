import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:boi_marronzinho/app/data/models/produto/carrinho.dart';
import 'package:boi_marronzinho/app/data/models/produto/produto.dart';
import 'package:boi_marronzinho/app/data/repositories/produto/produto_repository.interface.dart';
import 'package:boi_marronzinho/app/data/enumerators/endpoints.enum.dart';
import 'package:boi_marronzinho/app/data/request_repository.dart';
import 'package:dio/dio.dart';

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
  static const String carrinhoAtualizaQuantidadeUrl = '/lojas/carrinho/atualiza-quantidade-item/';


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

      return (valid: true, reason: 'Compra realizada com sucesso!', data: response.data);
    } catch (error, trace) {
      return errorResponse(error, trace: trace);
    }
  }

  @override
  Future<dynamic> addProduto({
    required String nome,
    required String descricao,
    required double precoBoicoins,
    required double precoReal,
    required int quantidadeEmEstoque,
    required File image, // Arquivo de imagem para upload
  }) async {
    final url = apiHelpers.buildUrl(
        url: adicionarProdutoUrl, endpoint: Endpoints.BOI_MARRONZINHO);

    // Crie o JSON com os dados do produto como uma string JSON válida
    final productData = {
      'nome': nome,
      'descricao': descricao,
      'precoBoicoins': precoBoicoins,
      'precoReal': precoReal,
      'quantidadeEmEstoque': quantidadeEmEstoque,
    };

    // Use jsonEncode para converter o mapa em uma string JSON válida
    final productDataString = jsonEncode(productData);

    // Crie um FormData para enviar o multipart/form-data
    final formData = FormData.fromMap({
      'request': productDataString, // Adicione o JSON como string no campo 'request'
      'file': await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
    });

    try {
      // Faça a requisição POST com multipart/form-data
      final response = await client.post(url, formData);

      if (response.statusCode == 200) {
        return (valid: true, reason: null, data: response.data);
      } else {
        return (
          valid: false,
          reason: response.statusMessage,
          data: response.data
        );
      }
    } catch (error, stacktrace) {
      print("Erro: $error");
      print("Stacktrace: $stacktrace");
      return errorResponse(error, trace: stacktrace);
    }
  }

  Future atualizarQuantidadeCarrinhoProduto({required String produtoId, required int quantidade, required String usuarioId}) async {
    final url = apiHelpers.buildUrl(
        url: carrinhoAtualizaQuantidadeUrl + usuarioId, endpoint: Endpoints.BOI_MARRONZINHO);

    final bodyRequest = {
      'produtoId': produtoId,
      'quantidade': quantidade
    };

    try {
      final response = await client.put(url, bodyRequest);

      final invalidResponse = isValidResponse<List<Produto>>(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      return (
      valid: true,
      reason: 'Sucesso ao atualizar quantidade!',
      data: 'Quantidade atualizada com sucesso');
    } catch (e, stackTrace) {
      log('Error ', error: e, stackTrace: stackTrace);
      return (
      valid: false,
      reason: 'Erro interno durante a requisição',
      data: e
      );
    }
  }


  @override
  Future atualizaProduto({required String produtoId}) {
    // TODO: implement atualizaProduto
    throw UnimplementedError();
  }



  @override
  Future removeProduto({required String produtoId}) async {
    final url = apiHelpers.buildUrl(
        url: removerProdutoUrl + produtoId, endpoint: Endpoints.BOI_MARRONZINHO);

    try {
      final response = await client.delete(url, {});
      final invalidResponse = isValidResponse(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      return (valid: true, reason: null, data: null);
    } catch (error, trace) {
      return errorResponse(error, trace: trace);
    }
  }
}
