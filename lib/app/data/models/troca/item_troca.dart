class ItemTroca {
  final String id;
  final String nomeItem;
  final String descricao;
  final String unidadeMedida;
  final double boicoinsPorUnidade;

  ItemTroca({
    required this.id,
    required this.nomeItem,
    required this.descricao,
    required this.unidadeMedida,
    required this.boicoinsPorUnidade,
  });

  factory ItemTroca.fromMap(Map<String, dynamic> map) {
    return ItemTroca(
      id: map['id'] ?? '',
      nomeItem: map['nomeItem'] ?? '',
      descricao: map['descricao'] ?? '',
      unidadeMedida: map['unidadeMedida'] ?? '',
      boicoinsPorUnidade: (map['boicoinsPorUnidade'] as num).toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeItem': nomeItem,
      'descricao': descricao,
      'unidadeMedida': unidadeMedida,
      'boicoinsPorUnidade': boicoinsPorUnidade,
    };
  }
}
