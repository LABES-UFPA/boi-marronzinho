class Oficina {
  final String id;
  final String nomeOficina;
  final String descricao;
  final double precoBoicoin;
  final double precoReal;
  final DateTime dataOficina;
  final int limiteParticipantes;
  final String pontoMapaId;

  Oficina({
    required this.id,
    required this.nomeOficina,
    required this.descricao,
    required this.precoBoicoin,
    required this.precoReal,
    required this.dataOficina,
    required this.limiteParticipantes,
    required this.pontoMapaId,
  });

  factory Oficina.fromMap(Map<String, dynamic> map) {
    return Oficina(
      id: map['id'],
      nomeOficina: map['nome'],
      descricao: map['descricao'],
      precoBoicoin: (map['precoBoicoins'] as num).toDouble(),
      precoReal: (map['precoReal'] as num).toDouble(),
      dataOficina: DateTime.parse(map['dataEvento']),
      limiteParticipantes: map['limiteParticipantes'],
      pontoMapaId: map['pontoMapaId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeOficina': nomeOficina,
      'descricao': descricao,
      'precoBoicoin': precoBoicoin,
      'precoReal': precoReal,
      'dataOficina': dataOficina.toIso8601String(),
      'limiteParticipantes': limiteParticipantes,
      'pontoMapaId': pontoMapaId,
    };
  }
}
