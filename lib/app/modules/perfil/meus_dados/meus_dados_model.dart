class MeusDados {
  final String username;
  final String email;

  MeusDados({required this.username, required this.email});

  factory MeusDados.fromMap(Map<String, dynamic> map) {
    return MeusDados(username: map['username'], email: map['email']);
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email
    };
  }

}