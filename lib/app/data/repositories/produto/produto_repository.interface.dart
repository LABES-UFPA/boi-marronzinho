abstract interface class IProdutosRepository {
  Future<dynamic> fetchProdutos();
  Future<dynamic> comprarProduto({required String usuarioId, required String produtoId});
}
