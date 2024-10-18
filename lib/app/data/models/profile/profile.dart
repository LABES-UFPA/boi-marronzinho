class Profile {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final double saldoBoicoins;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.saldoBoicoins,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      saldoBoicoins: (map['saldoBoicoins'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'saldoBoicoins': saldoBoicoins,
    };
  }
}