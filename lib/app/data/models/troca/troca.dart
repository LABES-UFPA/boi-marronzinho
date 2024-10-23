class Troca {
  final String id;
  final String usuarioId;
  final String itemTrocaId;
  final double quantidade;
  final double boicoinsRecebidos;
  final String status;
  final DateTime dataDoacao;

  Troca({
    required this.id,
    required this.usuarioId,
    required this.itemTrocaId,
    required this.quantidade,
    required this.boicoinsRecebidos,
    required this.status,
    required this.dataDoacao,
  });

  factory Troca.fromMap(Map<String, dynamic> map) {
    return Troca(
      id: map['id'],
      usuarioId: map['usuarioId'],
      itemTrocaId: map['itemTrocaId'],
      quantidade: (map['quantidade'] as num).toDouble(),
      boicoinsRecebidos: (map['boicoinsRecebidos'] as num).toDouble(),
      status: map['status'],
      dataDoacao: DateTime.parse(map['dataDoacao']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuarioId': usuarioId,
      'itemTrocaId': itemTrocaId,
      'quantidade': quantidade,
      'boicoinsRecebidos': boicoinsRecebidos,
      'status': status,
      'dataDoacao': dataDoacao.toIso8601String(),
    };
  }
}
