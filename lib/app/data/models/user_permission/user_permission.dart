class UserPermission {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String tipoUsuario;

  UserPermission({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.tipoUsuario,
  });

  factory UserPermission.fromMap(Map<String, dynamic> map) {
    return UserPermission(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      tipoUsuario: map['tipoUsuario'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'tipoUsuario': tipoUsuario,
    };
  }
}
