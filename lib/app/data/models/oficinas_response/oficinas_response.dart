class Oficina {
  final String id;
  final String nomeOficina;
  final String descricao;
  final double precoBoicoin;
  final double precoReal;
  final DateTime dataOficina;
  final int limiteParticipantes;
  final int participantesAtual; // Adicionado para armazenar o número atual de participantes
  final String imagem; // Adicionado para armazenar a imagem da oficina

  Oficina({
    required this.id,
    required this.nomeOficina,
    required this.descricao,
    required this.precoBoicoin,
    required this.precoReal,
    required this.dataOficina,
    required this.limiteParticipantes,
    required this.participantesAtual,
    required this.imagem,
  });

  factory Oficina.fromMap(Map<String, dynamic> map) {
    return Oficina(
      id: map['id'],
      nomeOficina: map['nome'] ?? '', // Prevenir null
      descricao: map['descricao'] ?? '', // Prevenir null
      precoBoicoin: (map['precoBoicoins'] as num).toDouble(),
      precoReal: (map['precoReal'] as num).toDouble(),
      dataOficina: DateTime.parse(map['dataEvento']),
      limiteParticipantes: map['limiteParticipantes'] ?? 0, // Prevenir null
      participantesAtual: map['participantesAtual'] ?? 0, // Prevenir null
      imagem: map['imagem'] ?? '', // Prevenir null
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nomeOficina,
      'descricao': descricao,
      'precoBoicoins': precoBoicoin,
      'precoReal': precoReal,
      'dataEvento': dataOficina.toIso8601String(),
      'limiteParticipantes': limiteParticipantes,
      'participantesAtual': participantesAtual,
      'imagem': imagem,
    };
  }
}
