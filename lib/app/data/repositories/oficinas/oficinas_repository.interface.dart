import 'dart:io';

abstract interface class IOficinasRepository {
  Future<dynamic> fetchOficinas();
  Future<dynamic> deletarOficinas({required String id});
  Future<dynamic> cadastrarOficina(
      {required String nome,
      required String descricao,
      required double precoBoicoins,
      required double precoReal,
      required String dataOficina,
      required int limiteOficina,
      required File imagem,
      required String urlEndereco});
  Future<dynamic> editarOficina({
    required String id,
    required String nome,
    required String descricao,
    required double precoBoicoins,
    required double precoReal,
    required String dataOficina,
    required int limiteOficina,
    required File imagem,
    required String urlEndereco,
  });
}
