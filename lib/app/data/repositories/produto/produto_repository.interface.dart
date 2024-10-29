abstract interface class IProdutosRepository {
  Future<dynamic> fetchProdutos();
  Future<dynamic> addProduto();
  Future<dynamic> removeProduto({required String produtoId});
  Future<dynamic> atualizaProduto({required String produtoId});

  // Carrinho
  Future<dynamic> addItemCarrinho({required String usuarioId, required String produtoId, required int quantidade});
  Future<dynamic> getCarrinho({required String usuarioId});
  Future<dynamic> removeItemCarrinho({required String usuarioId, required String itemId});

  // Finalizar compra
  Future<dynamic> finalizarCompra({required String usuarioId});
}
