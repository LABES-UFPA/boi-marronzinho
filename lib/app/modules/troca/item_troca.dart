class Item_Troca{
  final int id;
  final String name;

  Item_Troca({required this.id, required this.name});

  factory Item_Troca.fromJson(Map<String, dynamic> json) {
    return Item_Troca(
      id: json['id'],
      name: json['name'],
    );
  }
}