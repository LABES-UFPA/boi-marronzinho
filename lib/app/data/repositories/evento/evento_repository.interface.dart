abstract interface class IEventosRepository {
  Future<dynamic> fetchEventos();
  Future<dynamic> fetchEventoPorId({
    required String id,
  });
  Future<dynamic> deletarEvento({
    required String id,
  });
  Future<dynamic> cadastrarEvento({
    required String nome,
    required String descricao,
    required String dataEvento,
    required String urlEndereco,
  });
  Future<dynamic> editarEvento({
    required String id,
    required String nome,
    required String descricao,
    required String dataEvento,
    required String urlEndereco,
  });
}
