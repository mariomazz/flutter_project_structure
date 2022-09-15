import 'dart:convert';

class UserLogged {
  final String id;
  final String? avatarUrl;
  final bool isSpidUser;
  final String email;
  final String firstName;
  final String fiscalCode;
  final String lastName;
  final String? phoneNumber;

  UserLogged({
    required this.id,
    this.avatarUrl,
    required this.isSpidUser,
    required this.email,
    required this.firstName,
    required this.fiscalCode,
    required this.lastName,
    this.phoneNumber,
  });

  UserLogged copyWith({
    String? id,
    String? avatarUrl,
    bool? isSpidUser,
    String? email,
    String? firstName,
    String? fiscalCode,
    String? lastName,
    String? phoneNumber,
  }) {
    return UserLogged(
      id: id ?? this.id,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isSpidUser: isSpidUser ?? this.isSpidUser,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      fiscalCode: fiscalCode ?? this.fiscalCode,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'avatarUrl': avatarUrl,
      'isSpidUser': isSpidUser,
      'email': email,
      'firstName': firstName,
      'fiscalCode': fiscalCode,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserLogged.fromMap(Map<String, dynamic> map) {
    return UserLogged(
      id: map['id'] ?? '',
      avatarUrl: map['avatarUrl'],
      isSpidUser: map['isSpidUser'] ?? false,
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      fiscalCode: map['fiscalCode'] ?? '',
      lastName: map['lastName'] ?? '',
      phoneNumber: map['phoneNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLogged.fromJson(String source) =>
      UserLogged.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserLogged(id: $id, avatarUrl: $avatarUrl, isSpidUser: $isSpidUser, email: $email, firstName: $firstName, fiscalCode: $fiscalCode, lastName: $lastName, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserLogged &&
        other.id == id &&
        other.avatarUrl == avatarUrl &&
        other.isSpidUser == isSpidUser &&
        other.email == email &&
        other.firstName == firstName &&
        other.fiscalCode == fiscalCode &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        avatarUrl.hashCode ^
        isSpidUser.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        fiscalCode.hashCode ^
        lastName.hashCode ^
        phoneNumber.hashCode;
  }
}
