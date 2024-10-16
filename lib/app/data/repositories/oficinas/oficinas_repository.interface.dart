abstract interface class IOficinasRepository {
  Future<dynamic> fetchOficinas();
  Future<dynamic> cadastrarOficina({
    required String nome,
    required String descricao,
    required double precoBoicoin,
    required double precoReal,
    required String dataOficina,
    required int limiteOficina
  });
}
