import 'dart:developer';
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

}
