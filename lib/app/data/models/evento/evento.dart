class Evento {
  final String id;
  final String nome;
  final String descricao;
  final DateTime dataEvento;
  final String imagem;
  final String linkEndereco;

  Evento({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.dataEvento,
    required this.imagem,
    required this.linkEndereco,
  });

  factory Evento.fromMap(Map<String, dynamic> map) {
    return Evento(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      dataEvento: DateTime.parse(map['dataEvento']),
      imagem: map['imagem'] ?? '', // Prevenir null
      linkEndereco: map['linkEndereco'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'dataEvento': dataEvento.toIso8601String(),
      'linkEndereco': linkEndereco,
    };
  }
}