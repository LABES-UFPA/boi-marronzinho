class Carrinho {
  final String id;
  final String usuarioId;
  final String produtoId;
  final int quantidade;
  final double precoUnitario;
  final DateTime criadoEm;

  Carrinho({
    required this.id,
    required this.usuarioId,
    required this.produtoId,
    required this.quantidade,
    required this.precoUnitario,
    required this.criadoEm,
  });

  // Construtor factory para criar um Pedido a partir de um mapa
  factory Carrinho.fromMap(Map<String, dynamic> map) {
    return Carrinho(
      id: map['id'] ?? '',
      usuarioId: map['usuarioId'],
      produtoId: map['produtoId'],
      quantidade: map['quantidade'],
      precoUnitario: (map['precoUnitario'] as num).toDouble(),
      criadoEm: DateTime.parse(map['criadoEm']),
    );
  }

  // Converte a instância de Pedido para um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuarioId': usuarioId,
      'produtoId': produtoId,
      'quantidade': quantidade,
      'precoUnitario': precoUnitario,
      'criadoEm': criadoEm.toIso8601String(),
    };
  }
}
