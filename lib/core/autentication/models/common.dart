// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:platforms_auth_service/core/models/auth_data.dart';

class AuthUserData {
  final UserData userData;
  final AuthData authData;

  factory AuthUserData.from(
      {required AuthData authData, required UserData userData}) {
    return AuthUserData(authData: authData, userData: userData);
  }

  AuthUserData({
    required this.userData,
    required this.authData,
  });
}

class UserData {
  final String? email;
  final String? preferred_username;
  final String? FiscalCode;
  final String? UserId;
  final String? TenantId;
  UserData({
    this.email,
    this.preferred_username,
    this.FiscalCode,
    this.UserId,
    this.TenantId,
  });

  UserData copyWith({
    String? email,
    String? preferred_username,
    String? FiscalCode,
    String? UserId,
    String? TenantId,
  }) {
    return UserData(
      email: email ?? this.email,
      preferred_username: preferred_username ?? this.preferred_username,
      FiscalCode: FiscalCode ?? this.FiscalCode,
      UserId: UserId ?? this.UserId,
      TenantId: TenantId ?? this.TenantId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'preferred_username': preferred_username,
      'FiscalCode': FiscalCode,
      'UserId': UserId,
      'TenantId': TenantId,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      email: map['email'],
      preferred_username: map['preferred_username'],
      FiscalCode: map['FiscalCode'],
      UserId: map['UserId'],
      TenantId: map['TenantId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(email: $email, preferred_username: $preferred_username, FiscalCode: $FiscalCode, UserId: $UserId, TenantId: $TenantId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.email == email &&
        other.preferred_username == preferred_username &&
        other.FiscalCode == FiscalCode &&
        other.UserId == UserId &&
        other.TenantId == TenantId;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        preferred_username.hashCode ^
        FiscalCode.hashCode ^
        UserId.hashCode ^
        TenantId.hashCode;
  }
}
