class User {
  final String uid;
  final String email;
  final String? birthDate;
  final String? birthPlace;
  final String? city;

  User({
    required this.uid,
    required this.email,
    this.birthDate,
    this.birthPlace,
    this.city,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'birthDate': birthDate,
      'birthPlace': birthPlace,
      'city': city,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      email: map['email'],
      birthDate: map['birthDate'],
      birthPlace: map['birthPlace'],
      city: map['city'],
    );
  }
}