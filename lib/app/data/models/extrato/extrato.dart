class BoicoinsTransacoes {
  final String id;
  final String usuarioID;
  final double quantidade;
  final String tipoTransacao;
  final String descricao;
  final DateTime dataTransacao;
  final String? pedidoID;
  final String? doacaoID;
  final String? oficinaID;

  BoicoinsTransacoes({
    required this.id,
    required this.usuarioID,
    required this.quantidade,
    required this.tipoTransacao,
    required this.descricao,
    required this.dataTransacao,
    this.pedidoID,
    this.doacaoID,
    this.oficinaID,
  });

  factory BoicoinsTransacoes.fromMap(Map<String, dynamic> map) {
    return BoicoinsTransacoes(
      id: map['id'],
      usuarioID: map['usuarioID'],
      quantidade: (map['quantidade'] as num).toDouble(),
      tipoTransacao: map['tipoTransacao'],
      descricao: map['descricao'],
      dataTransacao: DateTime.parse(map['dataTransacao']),
      pedidoID: map['pedidoID'],
      doacaoID: map['doacaoID'],
      oficinaID: map['oficinaID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuarioID': usuarioID,
      'quantidade': quantidade,
      'tipoTransacao': tipoTransacao,
      'descricao': descricao,
      'dataTransacao': dataTransacao.toIso8601String(),
      'pedidoID': pedidoID,
      'doacaoID': doacaoID,
      'oficinaID': oficinaID,
    };
  }
}
