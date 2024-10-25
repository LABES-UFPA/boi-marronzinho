abstract interface class IProdutosRepository {
  Future<dynamic> fetchProdutos();
  Future<dynamic> comprarProduto({required String usuarioID, required String produtoId});
}
