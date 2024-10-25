class Produto {
  final String id;
  final String nome;
  final String descricao;
  final double precoBoicoins;
  final double precoReal;
  final int quantidadeEmEstoque;
  final String imagemURL;
  final DateTime criadoEm;

  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.precoBoicoins,
    required this.precoReal,
    required this.quantidadeEmEstoque,
    required this.imagemURL,
    required this.criadoEm,
  });

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'] ?? '',
      nome: map['nome'],
      descricao: map['descricao'],
      precoBoicoins: (map['precoBoicoins'] as num).toDouble(),
      precoReal: (map['precoReal'] as num).toDouble(),
      quantidadeEmEstoque: map['quantidadeEmEstoque'],
      imagemURL: map['imagemUrl'],
      criadoEm: DateTime.parse(map['criadoEm']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'precoBoicoins': precoBoicoins,
      'precoReal': precoReal,
      'quantidadeEmEstoque': quantidadeEmEstoque,
      'imagemUrl': imagemURL,
      'criadoEm': criadoEm.toIso8601String(),
    };
  }
}
