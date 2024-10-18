class UserCredentials {
  final String userId;
  final String email;

  const UserCredentials({
    required this.userId,
    required this.email,
  });

  factory UserCredentials.clean() =>
      const UserCredentials(userId: '', email: '');

  factory UserCredentials.fromMap(Map<String, dynamic> map) =>
      UserCredentials(
        userId: map['userId'] ?? '',
        email: map['email'] ?? '',
      );

  Map<String, dynamic> toMap() =>
      {
        'userId': userId,
        'email': email,
      };
}