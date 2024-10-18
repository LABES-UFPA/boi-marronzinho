class UserCredentials {
  final String userId;
  final String email;
  final String name;

  const UserCredentials({
    required this.userId,
    required this.email,
    required this.name,
  });

  factory UserCredentials.clean() =>
      const UserCredentials(userId: '', email: '', name: '');

  factory UserCredentials.fromMap(Map<String, dynamic> map) =>
      UserCredentials(
        userId: map['userId'] ?? '',
        email: map['email'] ?? '',
        name: map['name'] ?? '',
      );

  Map<String, dynamic> toMap() =>
      {
        'userId': userId,
        'email': email,
        'name': name,
      };
}