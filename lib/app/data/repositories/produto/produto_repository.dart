import 'dart:convert';
import 'dart:developer';
import 'dart:io';
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
  static const String carrinhoUrl = '/lojas/carrinho';
  static const String carrinhoAdicionarItemUrl = '/lojas/carrinho/adiciona-item';
  static const String carrinhoRemoverItemUrl = '/lojas/carrinho/remove-item/';
  static const String finalizarCompra = '/lojas/compra/finalizar';

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

  @override
  Future comprarProduto({required String usuarioId, required String produtoId}) async {
    final url = apiHelpers.buildUrl(url: finalizarCompra, endpoint: Endpoints.BOI_MARRONZINHO);
    final bodyRequest = {
      'usuarioId': usuarioId,
      'oficinaId': produtoId,
    };
    try {
      final response = await client.post(url, bodyRequest);
      final invalidResponse = isValidResponse(response);
      if (!invalidResponse.valid) {
        return invalidResponse;
      }

      return (valid: true, reason: 'Compra realizada com sucesso!', data: response.data);
    } catch (error, trace) {
      return errorResponse(error, trace: trace);
    }
  }

  Future<dynamic> cadastrarProduto({
    required String nome,
    required String descricao,
    required double precoBoicoins,
    required double precoReal,
    required int quantidadeEmEstoque,
    required File imagem,
  }) async {
    final url = apiHelpers.buildUrl(url: adicionarProdutoUrl, endpoint: Endpoints.BOI_MARRONZINHO);
      print('  Imagem: ${imagem.path}');
    final eventData = {
      'nome': nome,
      'descricao': descricao,
      'precoBoicoins': precoBoicoins,
      'precoReal': precoReal,
      'quantidadeEmEstoque': quantidadeEmEstoque,
    };
    final eventDataString = jsonEncode(eventData);
    final formData = FormData.fromMap({
      'request':
          eventDataString, // Adicione o JSON como string no campo 'request'
      'file': await MultipartFile.fromFile(imagem.path,
          filename: imagem.path.split('/').last),
    });

    try {
      // Faça a requisição POST com multipart/form-data
      final response = await client.post(
        url, formData,
        
      );

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

  

   Future<dynamic> deletarProduto({required String id}) async {
    final url = apiHelpers.buildUrl(url: removerProdutoUrl, endpoint: Endpoints.BOI_MARRONZINHO);
    final bodyRequest = {'id': id};

    try {
      final response = await client.delete(url, bodyRequest);
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
